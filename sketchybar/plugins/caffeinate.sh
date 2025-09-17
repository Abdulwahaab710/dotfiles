#!/bin/bash

CAFFINATE_ID=$(pmset -g assertions | grep "caffeinate" | awk '{print $2}' | cut -d '(' -f1 | head -n 1)
EMPTY_CUP_ICON=""
EMPTY_CUP_PADDING_LEFT=8
EMPTY_CUP_PADDING_RIGHT=6


FULL_CUP_ICON=""
FULL_CUP_PADDING_LEFT=7
FULL_CUP_PADDING_RIGHT=5

# It was not a button click
if [ -z "$BUTTON" ]; then
  if [ -z "$CAFFINATE_ID" ]; then
    sketchybar --set "$NAME" \
      icon=$EMPTY_CUP_ICON \
      icon.padding_left=$EMPTY_CUP_PADDING_LEFT \
      icon.padding_right=$EMPTY_CUP_PADDING_RIGHT
  else
    sketchybar --set "$NAME" \
      icon=$FULL_CUP_ICON \
      icon.padding_left=$FULL_CUP_PADDING_LEFT \
      icon.padding_right=$FULL_CUP_PADDING_RIGHT
  fi
  exit 0
fi

# It is a mouse click
if [ -z "$CAFFINATE_ID" ]; then
  caffeinate -id &
  sketchybar --set "$NAME" \
    icon=$FULL_CUP_ICON \
    icon.padding_left=$FULL_CUP_PADDING_LEFT \
    icon.padding_right=$FULL_CUP_PADDING_RIGHT
else
  kill -9 "$CAFFINATE_ID"
  sketchybar --set "$NAME" \
    icon=$EMPTY_CUP_ICON \
    icon.padding_left=$EMPTY_CUP_PADDING_LEFT \
    icon.padding_right=$EMPTY_CUP_PADDING_RIGHT
fi
