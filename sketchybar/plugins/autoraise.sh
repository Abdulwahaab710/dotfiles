#!/bin/sh

source "$HOME/.config/sketchybar/colors.sh"

if pgrep -x AutoRaise >/dev/null || pgrep -x autoraise >/dev/null; then
  sketchybar --set "$NAME" \
    background.color="$GREEN"
else
  sketchybar --set "$NAME" \
    background.color="$GREY"
fi
