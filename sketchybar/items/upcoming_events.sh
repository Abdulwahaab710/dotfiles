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
  click_script="$PLUGIN_DIR/upcoming_events.sh" \
  popup.horizontal=on \
  popup.align=center \
  popup.height=135 \
  popup.background.border_width=2 \
  popup.background.corner_radius=6 \
  popup.background.border_color=0xffd0d0d0 \
  popup.background.color=0xfffafafa

# Add popup child items for displaying all upcoming events
for i in {1..5}; do
  sketchybar --remove cron.event.$i 2>/dev/null
  sketchybar --add item cron.event.$i popup.cron
  sketchybar --set cron.event.$i \
             label.font="Maple Mono NF CN:Regular:13" \
             label.color=0xff31353f \
             label.padding_left=8 \
             label.padding_right=8 \
             padding_left=4 \
             padding_right=4 \
             background.height=22 \
             background.corner_radius=4 \
             background.color=0xffeeeeee \
             drawing=off
done
