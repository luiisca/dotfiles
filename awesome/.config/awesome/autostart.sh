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

run "blueberry-tray"
run "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
run "numlockx on"
run "volumeicon"
run "syncthing"

run "redshift -l -12.811801:-79.110661"

run "playerctld daemon"
run "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify"
# run "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify --uri=spotify:track:1gwLjpvAbu6IVmVdAfPJ0G"
# run "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify --uri=spotify:playlist:6BGR7tHIUp8CdA6mNzm7l1"
echo 'ABOUT TO PLAY SONG 🤯'
sleep 1

# because it shares same process as playerctld which causes run fn to skip it.
playerctl open spotify:playlist:6BGR7tHIUp8CdA6mNzm7l1 &

# Spotify

