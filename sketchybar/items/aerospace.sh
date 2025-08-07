#!/bin/sh

sketchybar  -m  --add       item    aerospace   left                                \
                --set               aerospace   background.color=0xfff5a97f         \
                                                icon.color=0xff24273a               \
                                                label.drawing=off                   \
                                                script="$PLUGIN_DIR/aerospace.sh"   \
                --subscribe         aerospace   space_change mouse.clicked