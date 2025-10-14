#!/bin/bash

BATTERY_PATH="/sys/class/power_supply/BAT0"
BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
STATUS=$(cat "$BATTERY_PATH/status")

# Notify when battery is low
if [ "$BATTERY_LEVEL" -lt 20 ] && [ "$STATUS" != "Charging" ]; then
    notify-send -u critical "Battery Low ⚠️" "Battery is at ${BATTERY_LEVEL}%"
fi

# Notify when battery is full
# if [ "$BATTERY_LEVEL" -gt 95 ] && [ "$STATUS" == "Charging" ]; then
#     notify-send -u normal "Battery Full 🔋" "Battery is at ${BATTERY_LEVEL}%. Consider unplugging."
# fi

# Output JSON (empty text so nothing is shown in Waybar)
echo '{"text": ""}'
