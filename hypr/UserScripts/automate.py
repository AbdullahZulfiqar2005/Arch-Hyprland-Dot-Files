#!/usr/bin/env python3
import speech_recognition as sr
import os
import subprocess
import time
from difflib import get_close_matches

# ===============================================================
# 🎯 Voice Assistant (Minimal Notifications)
# ===============================================================

KNOWN_COMMANDS = [
    "firefox", "terminal", "vs code", "vscode", "code", "play", 
    "music", "quran", "aoa", "youtube", "notes", "exit"
]

def notify(title, message):
    """Send a desktop notification using notify-send."""
    try:
        subprocess.run(["notify-send", title, message])
    except Exception as e:
        print(f"⚠️ Notification error: {e}")

def execute_command(command):
    command = command.lower().strip()
    print(f"⚙️ Processing command: {command}")

    if command == "firefox":
        subprocess.Popen(["firefox"])
        notify("🌐 Firefox", "Opening browser...")

    elif command == "terminal":
        subprocess.Popen(["kitty"])
        notify("💻 Terminal", "Opening terminal...")

    elif command in ["code", "vscode", "vs code"]:
        subprocess.Popen(["code", "~"])
        notify("🧠 VS Code", "Opening Visual Studio Code...")

    elif command == "play":
        url = "https://youtu.be/gtgIlIXWEhI?si=HTyUfMxOy1pKOwgH"
        try:
            subprocess.Popen(["mpv", "--loop","--input-ipc-server=/tmp/mpvsocket", "--vid=no", url])
            notify("🎵 Catched", "Playing...")
        except Exception as e:
            notify("⚠️ Error", f"Could not play:: {e}")
            print(f"⚠️ Could not play : {e}")    
    
    elif command == "aoa":
        os.system("hyprctl dispatch workspace 5")
        subprocess.Popen([
            "kitty", "-e", "bash", "-c",
            "cd ~/Downloads/AoA && open 'Intro to algorithms.pdf'"
        ])
        notify("📘 AoA", "Opening Introduction to Algorithms...")

    elif command == "youtube":
        subprocess.Popen(["firefox", "https://www.youtube.com"])
        notify("📺 YouTube", "Opening YouTube...")

    elif command == "quran":
        subprocess.Popen(["firefox", "https://meet.google.com/jfd-ukei-gkf?hs=224"])
        notify("🕌 Quran Class", "Joining Quran Class...")

    elif command == "notes":
        subprocess.Popen(["nano", os.path.expanduser("~/Documents/notes.txt")])
        notify("📝 Notes", "Opening notes...")

    elif command == "exit":
        notify("👋 Goodbye", "Assistant is shutting down...")
        print("👋 Exiting assistant...")
        exit(0)

    else:
        notify("❓ Unknown Command", command)
        print("❓ Unknown command:", command)

def listen_and_execute():
    recognizer = sr.Recognizer()

    try:
        with sr.Microphone() as source:
            recognizer.adjust_for_ambient_noise(source, duration=0.5)
            audio = recognizer.listen(source, timeout=8, phrase_time_limit=6)

        said = recognizer.recognize_google(audio)
        print(f"🗣️ You said: {said}")

        said = said.lower().strip()
        match = get_close_matches(said, KNOWN_COMMANDS, n=1, cutoff=0.6)

        if match:
            execute_command(match[0])
        else:
            print("🤔 No close match found for:", said)
            notify("🤔 No Match", said)

    except sr.WaitTimeoutError:
        print("⏱️ Timeout: no speech detected.")
    except sr.UnknownValueError:
        print("😕 Could not understand what you said.")
    except sr.RequestError as e:
        notify("🚫 API Error", str(e))
        print(f"🚫 API Error: {e}")
    except Exception as e:
        notify("⚠️ Unexpected Error", str(e))
        print(f"⚠️ Unexpected error: {e}")

if __name__ == "__main__":
    notify("🎯 Voice Assistant Ready", "Say a command or 'exit' to quit.")
    print("🎯 Voice Assistant Ready! Say 'exit' to quit.\n")
    time.sleep(1)

    while True:
        listen_and_execute()
        time.sleep(1)
