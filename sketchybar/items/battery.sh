#!/bin/sh

attr_battery=(
  icon=$BATTERY_100
  icon.color=$GREEN
  icon.highlight_color=$BACKGROUND
  icon.padding_left=10
  icon.padding_right=2
  icon.font="SF Pro:SemiBold:16.0"
  label.padding_left=2
  label.padding_right=6
  label.font="SF Pro:Semibold:13.0"
  padding_left=2
  padding_right=8
  background.color=0x00000000
  update_freq=120
  script="$PLUGIN_DIR/battery.sh"
)


sketchybar    -m    --add         item    battery   right                                 \
                    --set                 battery   "${attr_battery[@]}"                  \
                    --subscribe           battery   system_woke power_source_change