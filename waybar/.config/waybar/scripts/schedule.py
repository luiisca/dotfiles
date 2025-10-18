#!/usr/bin/env python3

import json
import sys
from datetime import datetime, timedelta

def get_schedule():
    """Parses the schedule.conf file and returns a list of tasks."""
    schedule = []
    conf_file = Path(__file__).parent / "schedule.conf"
    with open(conf_file, "r") as f:
        for line in f:
            parts = line.strip().split(" ", 1)
            schedule.append({"time": parts[0], "task": parts[1]})
    return schedule

def get_current_and_next_tasks(schedule):
    """Determines the current and next tasks based on the current time."""
    now = datetime.now().time()
    now_str = now.strftime("%H:%M")

    crr_task = None
    next_task = None

    for i, item in enumerate(schedule):
        if item["time"] > now_str:
            next_task = item
            if i > 0:
                crr_task = schedule[i-1]
            else:
                crr_task = schedule[-1] 
            break

    if not crr_task and not next_task:
        crr_task = schedule[-1]

    return crr_task, next_task

def format_time_delta(delta):
    """Formats a timedelta object into a HH:MM string."""
    seconds = delta.total_seconds()
    hours = int(seconds // 3600)
    minutes = int((seconds % 3600) // 60)
    return f"{hours:02d}:{minutes:02d}"

def main():
    """Main script entry point."""
    if len(sys.argv) < 2:
        print(json.dumps({"text": "No arg"}))
        return

    schedule = get_schedule()
    crr_task, next_task = get_current_and_next_tasks(schedule)
    now = datetime.now()
    crr_task_time = datetime.strptime(crr_task["time"], "%H:%M").replace(year=now.year, month=now.month, day=now.day) if crr_task else None
    next_task_time = datetime.strptime(next_task["time"], "%H:%M").replace(year=now.year, month=now.month, day=now.day) if next_task else None

    output = {}

    if sys.argv[1] == "crr":
        if crr_task:
            if crr_task_time > now:
                crr_task_time -= timedelta(days=1)

            if next_task:
                time_diff = next_task_time - now
                next_task_time_str = next_task['time']
                text = f"󰐊 {crr_task['task']} (-{format_time_delta(time_diff)}, till {next_task_time_str})"
            else:
                text = f"󰐊 {crr_task['task']}"
            
            output['text'] = text
        else:
            output['text'] = "No current task"

    elif sys.argv[1] == "next":
        if next_task:
            if next_task_time < now:
                next_task_time += timedelta(days=1)

            time_diff = next_task_time - now
            output['text'] = f"󰒭 {next_task['task']} (in {format_time_delta(time_diff)})"
        else:
            output['text'] = "No next task"

    print(json.dumps(output))


if __name__ == "__main__":
    from pathlib import Path
    main()
