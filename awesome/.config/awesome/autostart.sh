#!/bin/bash

# Explain how does this work
# the run function checks if a process with the name of the first word in the provided command is already running, and if it’s not, it runs the entire command and puts it in the background
function run {
  cmd=$1
  echo "Running: $cmd"
  process=$(echo $cmd | awk '{print $1}')
  echo "Process: $process"
  if ! pgrep -f $process ;
  then
    echo "Starting: $cmd"
    eval "$cmd &"
  fi
}

# utilities
run "volumeicon"
run "nitrogen --restore"
run "redshift -l -12.811801:-79.110661"

# nvim
alacritty -e tmux &

# vivaldi web browser
syncthing &

# obsidian
obsidian &

# spotify
run "playerctld daemon"
run "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify"
sleep 3
playerctl open spotify:playlist:5VYkI1tzO63SBD92u7bv2S &
