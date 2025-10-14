#!/bin/bash
# Simple ThinkPad fan control script
# Usage: sudo ./fanctl.sh <fan level>
# Example: sudo ./fanctl.sh full-speed

# Check argument
if [ -z "$1" ]; then
    echo "Usage: $0 <fan level>"
    echo "Examples: full-speed, auto, disengaged, level 7"
    exit 1
fi

# Reload thinkpad_acpi with fan control enabled
modprobe -r thinkpad_acpi
modprobe thinkpad_acpi fan_control=1

# Apply fan level
echo level "$1" | tee /proc/acpi/ibm/fan > /dev/null

# Show desktop notification (non-root user)
sudo -u "$SUDO_USER" DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u "$SUDO_USER")/bus \
    notify-send "ThinkPad Fan Control" "Fan set to: $1"
