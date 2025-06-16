#!/bin/bash

sketchybar --add item cron right \
  --set cron icon=  \
  label="..." \
  display=1 \
  update_freq=120 \
  icon.font="Hack Nerd Font:Bold:17.0" \
  background.drawing=on \
  icon.padding_left=12 \
  label.padding_right=12 \
  background.border_color="$ACCENT_COLOR" \
  background.border_width=0 \
  background.shadow.angle=90 \
  background.shadow.color="$ACCENT_COLOR" \
  background.shadow.distance=1 \
  background.shadow.drawing=on \
  script="$PLUGIN_DIR/upcoming_events.sh"
# --subscribe cron mouse.entered mouse.exited \
