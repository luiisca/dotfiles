#!/usr/bin/env python3
import sys
import subprocess
import json

def get_current_tlp_mode():
    """
    Checks the current TLP mode using a direct shell pipeline for efficiency.
    Returns 'AC', 'BAT', or 'UNKNOWN'.
    """
    command = "tlp-stat -s | grep 'Mode' | awk '{print $3}'"
    try:
        # Use shell=True to allow the pipeline characters (|) to be interpreted
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True,
            check=True
        )
        # print(result.stdout.strip())
        # The command's output is exactly the mode string we need.
        # .strip() removes any trailing newlines.
        return result.stdout.strip()
    except (FileNotFoundError, subprocess.CalledProcessError) as e:
        # Gracefully handle errors if tlp-stat fails or isn't found
        print(f"Could not determine TLP mode: {e}", file=sys.stderr)
        return 'UNKNOWN'

def perform_toggle(current_mode):
    """
    Switches the TLP mode using pkexec.
    """
    next_mode = 'bat' if current_mode == 'AC' else 'ac'
    try:
        subprocess.run(['pkexec', 'tlp', next_mode], check=True)
    except (FileNotFoundError, subprocess.CalledProcessError) as e:
        print(f"Error toggling TLP mode: {e}", file=sys.stderr)

def output_waybar_json(mode):
    """
    Formats the output for Waybar based on the current TLP mode.
    """
    if mode == 'AC':
        status = {
            "text": "\udb86\udc87",  # Nerd Font: nf-fa-bolt
            "tooltip": "Mode: Performance",
            "class": "AC"
        }
    elif mode == 'battery':
        status = {
            "text": "\udb80\udf2a",  # Nerd Font: nf-md-leaf
            "tooltip": "Mode: Power Saving",
            "class": "BAT"
        }
    else:
        status = {
            "text": "",  # Nerd Font: nf-fa-question_circle
            "tooltip": "Mode: Unknown",
            "class": "unknown"
        }
    print(json.dumps(status))

def main():
    # This logic remains the same.
    # It only performs a toggle when explicitly told to.
    if len(sys.argv) > 1 and sys.argv[1] == 'toggle':
        current_mode = get_current_tlp_mode()
        if current_mode != 'UNKNOWN':
            perform_toggle(current_mode)

    # This always runs to provide Waybar with the current (or new) state.
    final_mode = get_current_tlp_mode()
    output_waybar_json(final_mode)
    sys.stdout.flush()


if __name__ == "__main__":
    main()
