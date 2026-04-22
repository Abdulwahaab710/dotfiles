#!/bin/sh
sketchybar --add event claude_counters_update

sketchybar --add item claude_icon right \
           --set claude_icon \
                 icon="􀫸" \
                 icon.font="SF Pro:Regular:15.0" \
                 icon.color=$MAGENTA \
                 icon.padding_left=8 \
                 icon.padding_right=4 \
                 label.drawing=off \
                 background.padding_left=4 \
                 background.padding_right=4 \
                 drawing=off \
                 script="$PLUGIN_DIR/claude_code.sh" \
           --subscribe claude_icon claude_counters_update \
           \
           --add item claude_running right \
           --set claude_running \
                 icon="􀙚" \
                 icon.font="SF Pro:Regular:15.0" \
                 icon.color=$BLUE \
                 icon.padding_left=4 \
                 icon.padding_right=4 \
                 label="0" \
                 background.padding_left=4 \
                 background.padding_right=4 \
                 drawing=off \
                 script="$PLUGIN_DIR/claude_code.sh" \
           --subscribe claude_running claude_counters_update \
           \
           --add item claude_waiting right \
           --set claude_waiting \
                 icon="$BELL_DOT" \
                 icon.font="SF Pro:Regular:15.0" \
                 icon.color=$ORANGE \
                 icon.padding_left=4 \
                 icon.padding_right=4 \
                 label="0" \
                 background.padding_left=4 \
                 background.padding_right=4 \
                 drawing=off \
                 script="$PLUGIN_DIR/claude_code.sh" \
           --subscribe claude_waiting claude_counters_update
