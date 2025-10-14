#!/bin/bash

#Script to pause/play rofi beats

echo '{ "command": ["cycle", "pause"] }' | socat - /tmp/mpvsocket

