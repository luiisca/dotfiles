#!/bin/bash
TEMP_FILE=$(mktemp).png
ksnip -r -p "$TEMP_FILE" # Launch ksnip in rectangular mode and save to temp file
if [ -f "$TEMP_FILE" ]; then
    xclip -selection clipboard -t image/png -i "$TEMP_FILE"
    rm "$TEMP_FILE"
fi
