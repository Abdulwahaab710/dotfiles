#!/bin/sh


source "$HOME/.config/sketchybar/colors.sh"

cpu_top=(
  label.font="$FONT_LABEL:Semibold:7"
  label=CPU
  icon.drawing=off
  width=0
  padding_left=15
  y_offset=6
)

cpu_percent=(
  label.font="$FONT_LABEL:Heavy:12"
  label=CPU
  y_offset=-4
  padding_left=15
  width=55
  icon.drawing=off
  update_freq=2
  background.color=$TRANSPARENT
  mach_helper="$HELPER"
)

cpu_sys=(
  width=0
  graph.color=$RED
  graph.fill_color=$RED
  graph.line_width=1.0
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

cpu_user=(
  graph.color=$BLUE
  graph.line_width=1.0
  label.drawing=off
  icon.drawing=off
  background.height=30
  background.drawing=on
  background.color=$TRANSPARENT
)

sketchybar -m  --add item cpu.top left \
              --set cpu.top "${cpu_top[@]}"         \
                                                 \
              --add item cpu.percent left \
              --set cpu.percent "${cpu_percent[@]}" \
                                                 \
              --add graph cpu.sys left 100          \
              --set cpu.sys "${cpu_sys[@]}"         \
                                                 \
              --add graph cpu.user left 100         \
              --set cpu.user "${cpu_user[@]}"
