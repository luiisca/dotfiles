#!/usr/bin/env python3

import os
import sys
import subprocess

# Get URL from environment variable
url = os.environ.get("QUTE_URL")

if not url:
    print("Error: QUTE_URL environment variable not set.", file=sys.stderr)
    sys.exit(1)

# Get download directory (e.g., ~/Downloads)
# You might want to customize this
download_dir = os.path.expanduser("~/Downloads")
if not os.path.exists(download_dir):
    os.makedirs(download_dir)

# Construct the yt-dlp command
# -P specifies the download path
# Add any other yt-dlp options you prefer here
command = ["yt-dlp", "-P", download_dir, url]

try:
    # Start the download process in the background
    subprocess.Popen(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

    # Send a message back to qutebrowser
    qute_fifo = os.environ.get("QUTE_FIFO")
    if qute_fifo:
        with open(qute_fifo, "w") as f:
            f.write(f"message-info 'Starting yt-dlp download for {url}'\n")
    else:
        print(f"Starting yt-dlp download for {url}")

except FileNotFoundError:
    error_msg = "Error: 'yt-dlp' command not found. Make sure it's installed and in your PATH."
    print(error_msg, file=sys.stderr)
    qute_fifo = os.environ.get("QUTE_FIFO")
    if qute_fifo:
        with open(qute_fifo, "w") as f:
            f.write(f"message-error '{error_msg}'\n")
    sys.exit(1)
except Exception as e:
    error_msg = f"Error running yt-dlp: {e}"
    print(error_msg, file=sys.stderr)
    qute_fifo = os.environ.get("QUTE_FIFO")
    if qute_fifo:
        with open(qute_fifo, "w") as f:
            f.write(f"message-error '{error_msg}'\n")
    sys.exit(1)

sys.exit(0)
