#!/bin/bash

# Script for turning brightness on and off

get_brightness() {
    brightnessctl -m | cut -d, -f4 | tr -d '%'
}

current=$(get_brightness)

if (( $current > 0 )); then
	brightnessctl set 0
else
	brightnessctl set 500  # Max is 1515
fi
