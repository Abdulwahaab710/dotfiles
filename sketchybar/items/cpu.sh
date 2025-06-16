#!/bin/bash

sketchybar --add item cpu right \
  --set cpu update_freq=2 \
  icon=􀧓 \
  padding_left=0 \
  script="$PLUGIN_DIR/cpu.sh"
