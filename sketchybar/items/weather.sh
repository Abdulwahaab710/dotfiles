#!/bin/sh


#0xff181926
sketchybar --add item weather q \
    --set weather \
    icon=$LOCATION \
    icon.color=0xfff5bde6 \
    icon.font="Hack Nerd Font:Bold:15.0" \
    update_freq=1800 \
    script="$PLUGIN_DIR/weather.sh" \
    --subscribe weather system_woke
