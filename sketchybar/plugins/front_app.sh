#!/bin/sh

if [ -z $INFO ]; then
  ICON_PIC=":default:"
else
  ICON_PIC=$(sh "$HOME/.config/sketchybar/cache/get_icon.sh" "$INFO")
fi

sketchybar    -m    --set   "$NAME"         icon="$ICON_PIC" icon.padding_right=5 \
                    --set   "$NAME".name    label="$INFO"
