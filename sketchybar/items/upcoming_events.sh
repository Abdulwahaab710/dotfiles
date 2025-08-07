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
  script="$PLUGIN_DIR/upcoming_events.sh"
# --subscribe cron mouse.entered mouse.exited \

