#!/bin/sh

airpods=(
  icon="􀪷"
  icon.font="$FONT_ICON:Black:16"
  icon.color="$MAROON"
  padding_right=8
  padding_left=8
  label.drawing=on
  update_freq=300
  updates=on
  background.corner_radius=14
)

sketchybar -m --add event bluetooth_change "com.apple.bluetooth.status" \
              --add item headphones right \
              --set headphones "${airpods[@]}" \
              script="$PLUGIN_DIR/airpods.sh" \
              --subscribe headphones bluetooth_change
