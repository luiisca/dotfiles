#!/bin/bash

# Options for system actions with emojis as icons using Unicode code points
options="\
Shutdown\0icon\x1f\U23FB\n\
Reboot\0icon\x1f\U1F504\n\
Logout\0icon\x1f\U1F512"

# Rofi command to display the options
chosen=$(echo -e "$options" | rofi -dmenu -i -markup-rows -p "System")

# Execute the chosen option
case "$chosen" in
    *Shutdown*)
        systemctl poweroff
        ;;
    *Reboot*)
        systemctl reboot
        ;;
    *Logout*)
        awesome-client "awesome.quit()"
        ;;
    *)
        ;;
esac

