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
  click_script="sketchybar --set \$NAME popup.drawing=toggle"
  popup.horizontal=off
  popup.align=center
  popup.height=34
  popup.background.border_width=1
  popup.background.corner_radius=12
  popup.background.border_color="$BAR_BORDER_COLOR"
  popup.background.color="$POPUP_BACKGROUND_COLOR"
)

sketchybar -m --add event bluetooth_change "com.apple.bluetooth.status" \
              --add item headphones right \
              --set headphones "${airpods[@]}" \
              script="$PLUGIN_DIR/airpods.sh" \
              --subscribe headphones bluetooth_change

for i in {1..8}; do
  sketchybar --add item headphones.device.$i popup.headphones \
             --set headphones.device.$i \
                   icon.font="$FONT_ICON:Regular:14" \
                   icon.padding_left=12 \
                   icon.padding_right=8 \
                   label.font="Maple Mono NF CN:Regular:13" \
                   label.color="$TEXT" \
                   label.padding_right=12 \
                   background.drawing=off \
                   drawing=off
done
