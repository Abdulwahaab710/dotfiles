#!/bin/sh
ACTION="$1"
SESSION="$(tmux display-message -p '#S' 2>/dev/null | tr '/' '_' || echo 'unknown')"
WINDOW="$(tmux display-message -p '#I' 2>/dev/null || echo '0')"
INSTANCE="${SESSION}_${WINDOW}"
RUNNING_DIR="/tmp/claude_instances/running"
WAITING_DIR="/tmp/claude_instances/waiting"
mkdir -p "$RUNNING_DIR" "$WAITING_DIR"

case "$ACTION" in
  start)
    touch "$RUNNING_DIR/$INSTANCE"
    rm -f "$WAITING_DIR/$INSTANCE"
    ;;
  stop)
    rm -f "$RUNNING_DIR/$INSTANCE" "$WAITING_DIR/$INSTANCE"
    ;;
  waiting)
    touch "$RUNNING_DIR/$INSTANCE"
    touch "$WAITING_DIR/$INSTANCE"
    ;;
  active)
    rm -f "$WAITING_DIR/$INSTANCE"
    ;;
esac

RUNNING=$(ls "$RUNNING_DIR" 2>/dev/null | wc -l | tr -d ' ')
WAITING=$(ls "$WAITING_DIR" 2>/dev/null | wc -l | tr -d ' ')

SKETCHYBAR=/opt/homebrew/bin/sketchybar

if [ "$RUNNING" -gt 0 ]; then
  $SKETCHYBAR --set claude_icon drawing=on \
              --set claude_running drawing=on label="$RUNNING"
else
  $SKETCHYBAR --set claude_icon drawing=off \
              --set claude_running drawing=off
fi

if [ "$WAITING" -gt 0 ]; then
  $SKETCHYBAR --set claude_waiting drawing=on label="$WAITING"
else
  $SKETCHYBAR --set claude_waiting drawing=off
fi
