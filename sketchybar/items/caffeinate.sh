#!/bin/sh

# sketchybar  -m  --add       item    caffeinate   left                                \
#                 --set               caffeinate   background.color=0xfff5a97f         \
#                                                 icon.color=0xff24273a               \
#                                                 label.drawing=off                   \
#                                                 script="$PLUGIN_DIR/caffeinate.sh"   \
#                 --subscribe         caffeinate   space_change mouse.clicked

sketchybar --add item caffeinate left \
  --set caffeinate script="$PLUGIN_DIR/caffeinate.sh" \
  click_script="$PLUGIN_DIR/caffeinate.sh" \
  background.color=0xfff5a97f \
  icon.color=0xff24273a               \
  icon.font="Hack Nerd Font:Regular:15.0" \
  label.drawing=off                   \
  icon=
