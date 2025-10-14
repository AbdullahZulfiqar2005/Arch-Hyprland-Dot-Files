#!/bin/bash

# Path to battery info (check with: ls /sys/class/power_supply/)
BAT_PATH="/sys/class/power_supply/BAT0"
LOW_LEVEL=20
NOTIFY_CMD="notify-send -u critical -t 5000 '⚠️ Battery Low' 'Battery below ${LOW_LEVEL}%!'"

# Check if the battery path exists
if [[ ! -d "$BAT_PATH" ]]; then
    echo "Battery path not found: $BAT_PATH"
    exit 1
fi

# Get capacity and status
CAPACITY=$(cat "$BAT_PATH/capacity")
STATUS=$(cat "$BAT_PATH/status")

# Only notify if battery is discharging and below threshold
if [[ "$STATUS" == "Discharging" && "$CAPACITY" -lt "$LOW_LEVEL" ]]; then
    # Optional: prevent spam — use a lock file
    LOCKFILE="/tmp/battery_warn.lock"
    if [[ ! -f "$LOCKFILE" ]]; then
        eval "$NOTIFY_CMD"
        touch "$LOCKFILE"
    fi
else
    # If charging or above threshold, remove lock
    rm -f /tmp/battery_warn.lock
fi
