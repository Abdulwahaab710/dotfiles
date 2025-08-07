#!/bin/sh

attr_network=(
  icon=$WIFI_CONNECTED
  icon.color=$YELLOW
  icon.highlight_color=$BACKGROUND
  icon.padding_left=6
  icon.padding_right=2
  icon.font="SF Pro:SemiBold:14.0"
  #label="ON"
  label.padding_left=2
  label.padding_right=20
  label.font="SF Pro:Semibold:13.0"
  label.width=0
  padding_left=1
  padding_right=2
  background.color=$NETS_LEFT
  background.height=26
  background.corner_radius=15
  update_freq=30
  script="$PLUGIN_DIR/network.sh"
)

attr_net_spr=(
  icon=􀄧
  icon.color=$NETS_LEFT
  icon.padding_left=0
  icon.padding_right=4
  icon.font="$FONT_LABEL:Bold:36.0"
  icon.y_offset=1
  label.drawing=off
  padding_left=-17
  padding_right=2
  background.color=0x00000000
)

attr_net_bat=(
  background.color=$NETS_RIGHT
  background.border_width=1
  background.height=28
  background.corner_radius=15
  background.border_color=$NETS_BORDER
  background.padding_left=0
  padding_left=0
)

sketchybar    -m    --add         item      net_spr     right                                 \
                    --set                   net_spr      "${attr_net_spr[@]}"                 \
                                                                                              \
                    --add         item      network     right                                 \
                    --set                   network     "${attr_network[@]}"                  \
                    --subscribe             network     wifi_change                           \
                                                        mouse.clicked                         \
                                                                                              \
                    --add         bracket   net_bat     network                               \
                                                        net_spr                               \
                                                        battery                               \
                    --set                   net_bat     "${attr_net_bat[@]}"
