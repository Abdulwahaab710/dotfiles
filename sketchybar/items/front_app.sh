#!/bin/sh

source $CONFIG_DIR/colors.sh
source $CONFIG_DIR/icons.sh
source $CONFIG_DIR/settings.sh

attr_front_app=(
    background.color=0xffa6da95
    background.padding_left=0     
    background.padding_right=0
    background.corner_radius=5 
    icon.font="$FONT_ICON:Regular:15.0" 
    icon.y_offset=1        
    icon.color=0xff24273a
    label.drawing=no   
    script="$PLUGIN_DIR/front_app.sh" 
)

attr_front_app_spr=(
    background.color=0x00000000
    background.padding_left=-3
    icon=
    icon.color=0xffa6da95
    icon.font="$FONT_LABEL:Bold:20.0"
    icon.padding_left=0
    icon.padding_right=0
    icon.y_offset=1
    label.drawing=no
)

attr_front_app_name=(
    background.color=0x00000000
    background.padding_right=0
    icon.drawing=off
    label.font="$FONT_LABEL:Bold:12.0"
    label.drawing=yes
)


sketchybar  -m  --add       item        front_app               left                        \
                --set                   front_app               "${attr_front_app[@]}"      \
                                                                                            \
                --add       item        front_app.separator     left                        \
                --set                   front_app.separator     "${attr_front_app_spr[@]}"  \
                                                                                            \
                --add       item        front_app.name          left                        \
                --set                   front_app.name          "${attr_front_app_name[@]}" \
                                                                                            \
                --add       bracket     front_app_bracket       front_app                   \
                                                                front_app.separator         \
                                                                front_app.name              \
                --subscribe front_app   front_app_switched