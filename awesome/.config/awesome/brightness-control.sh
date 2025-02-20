#!/bin/bash
# Ultra-fast brightness control with caching and lock-free checks

# Config
lock_file="/tmp/brightness.lock"
log_file="/tmp/brightness.log"
step=15
cache_file="/tmp/brightness.cache"

# Read/write cached brightness (atomic)
get_cache() { [ -f "$cache_file" ] && cat "$cache_file" || echo 50; }
set_cache() { echo "$1" > "$cache_file"; }

# Preliminary check (lock-free, uses cached value)
direction=$1
cached_current=$(get_cache)
case $direction in
  up)   [ "$cached_current" -lt 100 ] || exit 0 ;;
  down) [ "$cached_current" -gt 0 ]   || exit 0 ;;
  *)    exit 1 ;;
esac

# Non-blocking lock to queue adjustments
exec 9>"$lock_file"
flock -n 9 || exit 0  # Exit if another instance is working

# Get real brightness (with lock held)
output=$(ddcutil getvcp 10 2>/dev/null)
current=$(echo "$output" | grep -oP "current value\s+=\s+\K\d+")
max=$(echo "$output" | grep -oP "max value\s+=\s+\K\d+")

# Validate against real hardware state
case $direction in
  up)   [ "$current" -lt "$max" ] || { flock -u 9; exit 0; } ;;
  down) [ "$current" -gt 0 ]      || { flock -u 9; exit 0; } ;;
esac

# Calculate new value
if [ "$direction" = "up" ]; then
  new=$((current + step))
  [ "$new" -gt "$max" ] && new=$max
else
  new=$((current - step))
  [ "$new" -lt 0 ] && new=0
fi

# Update cache and hardware (atomic)
set_cache "$new"
ddcutil setvcp 10 $new >> "$log_file" 2>&1

# Notification (non-blocking)
{
  notify-send -h int:value:$new -t 300 "Brightness" "$new/$max" &
} 2>/dev/null

# Release lock
flock -u 9
