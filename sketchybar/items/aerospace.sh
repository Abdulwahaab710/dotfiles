#!/bin/sh

sketchybar --add event aerospace_workspace_change

sketchybar  -m  --add       item    aerospace   left                                \
                --set               aerospace   background.color=0xfff5a97f         \
                                                icon.color=0xff24273a               \
                                                label.drawing=off                   \
                                                script="$PLUGIN_DIR/aerospace.sh"   \
                                                icon=                              \
                                                icon.font="Hack Nerd Font:Regular:15.0" \
                --subscribe         aerospace   space_change mouse.clicked aerospace_workspace_change
