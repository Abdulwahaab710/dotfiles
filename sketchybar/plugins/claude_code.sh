#!/bin/sh
source "$HOME/.config/sketchybar/colors.sh"
source "$HOME/.config/sketchybar/icons.sh"

case "$SENDER" in
  "claude_counters_update")
    RUNNING="${RUNNING:-0}"
    WAITING="${WAITING:-0}"

    if [ "$RUNNING" -gt 0 ]; then
      sketchybar --set claude_icon drawing=on \
                 --set claude_running drawing=on label="$RUNNING"
    else
      sketchybar --set claude_icon drawing=off \
                 --set claude_running drawing=off
    fi

    if [ "$WAITING" -gt 0 ]; then
      sketchybar --set claude_waiting drawing=on label="$WAITING"
    else
      sketchybar --set claude_waiting drawing=off
    fi
    ;;
esac
