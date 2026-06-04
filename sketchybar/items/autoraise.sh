#!/bin/sh

sketchybar --add item autoraise left \
  --set autoraise \
    icon="$LOCATION" \
    icon.font="SF Pro:Regular:14.0" \
    icon.color=0xff24273a \
    icon.padding_left=6 \
    icon.padding_right=7 \
    label.drawing=off \
    background.color=$GREY \
    background.height=26 \
    background.corner_radius=5 \
    update_freq=2 \
    script="$PLUGIN_DIR/autoraise.sh"
