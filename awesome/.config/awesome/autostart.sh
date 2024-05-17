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

function connect_bluetooth_earbuds {
    earbuds_mac="E8:EC:A3:20:82:47"

    # Function to handle connection errors
    handle_connection_error() {
        {
            echo "remove $earbuds_mac"
            sleep 2
            echo "power off"
            sleep 2
            echo "power on"
            sleep 2
            echo "scan on"
            sleep 5
        } | bluetoothctl
    }

    # Attempt to connect with retry and timeout
    connect_with_retry() {
        timeout=60 # Timeout in seconds
        start_time=$(date +%s)
        while true; do
            bluetoothctl -- connect $earbuds_mac && break || handle_connection_error
            current_time=$(date +%s)
            elapsed_time=$((current_time - start_time))
            if [ $elapsed_time -ge $timeout ]; then
                exit 1
            fi
        done
    }

    connect_with_retry
}

connect_bluetooth_earbuds &

# utilities
run "volumeicon"
run "nitrogen --restore"
run "redshift -P -O 2800"

# nvim
# alacritty -e tmux &

# vivaldi web browser
vivaldi --new-window "https://linear.app" &   # Linear app
sleep 2
vivaldi --new-window "https://chatgpt.com" &  # ChatGPT
sleep 2
vivaldi &  # General browsing
syncthing --no-browser &

# obsidian
obsidian &

# spotify
run "playerctld daemon"
run "LD_PRELOAD=/usr/local/lib/spotify-adblock.so spotify"
sleep 60
playerctl open spotify:playlist:5VYkI1tzO63SBD92u7bv2S &
