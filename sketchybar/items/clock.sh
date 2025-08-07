#!/bin/sh


sketchybar -m --add item clock right \
    --set clock \
    icon=󰃰 \
    icon.color=0xffed8796 \
    update_freq=10 \
    script="$PLUGIN_DIR/clock.sh"