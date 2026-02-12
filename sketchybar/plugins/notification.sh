#!/bin/sh

PID_FILE="/tmp/sketchybar_notification_timer.pid"

cancel_timer() {
  if [ -f "$PID_FILE" ]; then
    kill "$(cat "$PID_FILE")" 2>/dev/null
    rm -f "$PID_FILE"
  fi
}

case "$SENDER" in
  "send_message")
    cancel_timer
    sketchybar --set notification.text label="$MESSAGE" \
               --set notification popup.drawing=on

    if [ "$HOLD" != "true" ]; then
      (sleep 5 && sketchybar --set notification popup.drawing=off) &
      echo $! > "$PID_FILE"
    fi
    ;;
  "hide_message")
    cancel_timer
    sketchybar --set notification popup.drawing=off
    ;;
esac
