#!/bin/sh

update_space() {
  SPACE_ID=$FOCUSED_WORKSPACE

  case $SPACE_ID in
    "")
      ICON=
      ICON_PADDING_LEFT=7
      ICON_PADDING_RIGHT=7
      ;;
    1)
      ICON=󰅬
      ICON_PADDING_LEFT=7
      ICON_PADDING_RIGHT=7
      ;;
    2)
      ICON=󰅶
      ICON_PADDING_LEFT=7
      ICON_PADDING_RIGHT=7
      ;;
    4)
      ICON=󰈙
      ICON_PADDING_LEFT=7
      ICON_PADDING_RIGHT=7
      ;;
    *)
      ICON=$SPACE_ID
      ICON_PADDING_LEFT=9
      ICON_PADDING_RIGHT=10
      ;;
  esac

  sketchybar --set $NAME \
    icon=$ICON \
    icon.padding_left=$ICON_PADDING_LEFT \
    icon.padding_right=$ICON_PADDING_RIGHT
  }

case "$SENDER" in
  "mouse.clicked")
    # Reload sketchybar
    sketchybar --remove '/.*/'
    source $HOME/.config/sketchybar/sketchybarrc
    ;;
  *)
    update_space
    ;;
esac
