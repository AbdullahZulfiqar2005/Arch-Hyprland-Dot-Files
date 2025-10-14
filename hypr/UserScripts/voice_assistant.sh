#!/usr/bin/env bash
# ===============================================================
# 🎤 Voice Assistant Launcher Script
# Location: ~/.config/hypr/UserScripts/voice_assistant.sh
# Description: Launches automate.py (your Python voice assistant)
# ===============================================================

SCRIPT_DIR="$HOME/.config/hypr/UserScripts"
PYTHON_SCRIPT="$SCRIPT_DIR/automate.py"

# Optional: activate venv if you're using one
source "$HOME/venv/bin/activate"

# Run the Python script
python3 "$PYTHON_SCRIPT"
