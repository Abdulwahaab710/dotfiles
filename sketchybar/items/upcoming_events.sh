#!/bin/bash

# Add the item (fails silently if exists)
sketchybar --add item cron e

# Set properties (always works whether item is new or existing)
sketchybar --set cron \
  icon=  \
  label="..." \
  display=1 \
  update_freq=120 \
  icon.font="Hack Nerd Font:Bold:17.0" \
  background.drawing=on \
  icon.padding_left=12 \
  label.padding_right=12 \
  script="$PLUGIN_DIR/upcoming_events.sh" \
  click_script="sketchybar --set \$NAME popup.drawing=toggle" \
  popup.horizontal=off \
  popup.align=center \
  popup.height=34 \
  popup.background.border_width=1 \
  popup.background.corner_radius=12 \
  popup.background.border_color="$BAR_BORDER_COLOR" \
  popup.background.color="$POPUP_BACKGROUND_COLOR"

# Add popup child items for displaying all upcoming events
for i in {1..5}; do
  sketchybar --remove cron.event.$i 2>/dev/null
  sketchybar --add item cron.event.$i popup.cron
  sketchybar --set cron.event.$i \
             icon.drawing=off \
             label.font="Maple Mono NF CN:Regular:13" \
             label.color="$TEXT" \
             label.padding_left=12 \
             label.padding_right=12 \
             padding_left=0 \
             padding_right=0 \
             background.drawing=off \
             drawing=off
done
