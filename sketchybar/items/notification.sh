#!/bin/sh

sketchybar --add event send_message
sketchybar --add event hide_message

sketchybar --add item notification center \
           --set notification \
                 width=0 \
                 icon.drawing=off \
                 label.drawing=off \
                 popup.align=center \
                 popup.horizontal=on \
                 script="$PLUGIN_DIR/notification.sh" \
           --subscribe notification send_message hide_message \
                                                              \
           --add item notification.text popup.notification \
           --set notification.text \
                 icon.drawing=off \
                 background.color=0x00000000 \
                 label.font="$FONT_LABEL:Medium:14.0" \
                 label.color=0xffffffff \
                 label.padding_left=12 \
                 label.padding_right=12
