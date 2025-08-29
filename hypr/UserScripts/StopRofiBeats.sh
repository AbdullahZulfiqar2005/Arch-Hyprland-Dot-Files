mpv_pids=$(pgrep -x mpv)

if [ -n "$mpv_pids" ]; then
  # Get the PID of the mpv process used by mpvpaper (using the unique argument added)
  mpvpaper_pid=$(ps aux | grep -- 'unique-wallpaper-process' | grep -v 'grep' | awk '{print $2}')

  for pid in $mpv_pids; do
    if ! echo "$mpvpaper_pid" | grep -q "$pid"; then
      kill -9 $pid || true
    fi
  done
fi
