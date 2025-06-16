#!/bin/bash

sketchybar --add item weather left \
  --set weather \
  update_freq=600 \
  script="$PLUGIN_DIR/weather.sh" \
  icon.font="Hack Nerd Font:Bold:17.0"
