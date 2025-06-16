#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
source "$CONFIG_DIR/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused --format "%{workspace}")

if [ "$SENDER" == "mouse.entered" ]; then
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    exit 0
  fi
  sketchybar --set "$NAME" \
    background.drawing=on \
    label.color="$BACKGROUND" \
    icon.color="$BACKGROUND" \
    background.color="$ACCENT_COLOR"
  exit 0
fi

if [ "$SENDER" == "mouse.exited" ]; then
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    exit 0
  fi
  sketchybar --set "$NAME" \
    background.drawing=off \
    label.color="$ACCENT_COLOR" \
    icon.color="$ACCENT_COLOR" \
    background.color="$TRANSPARENT"
  exit 0
fi

icons=""

APPS_INFO=$(aerospace list-windows --workspace "$1" --json --format "%{monitor-appkit-nsscreen-screens-id}%{app-name}")

IFS=$'\n'
for sid in $(echo "$APPS_INFO" | jq -r "map ( .\"app-name\" ) | .[]"); do
  icons+=$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$sid")
  icons+="  "
done

for monitor_id in $(echo "$APPS_INFO" | jq -r "map ( .\"monitor-appkit-nsscreen-screens-id\" ) | .[]"); do
  monitor=$monitor_id
done

if [ -z "$monitor" ]; then
  monitor="1"
fi

# When icons is empty, set it to " "
if [ -z "$icons" ]; then
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --animate sin 10 \
      --set "$NAME" \
      y_offset=10 y_offset=0 \
      background.drawing=on

    sketchybar --set "$NAME" \
      display="$monitor" \
      drawing=on \
      label="$icons" \
      label.color="$BACKGROUND" \
      icon.color="$BACKGROUND" \
      background.color="$ACCENT_COLOR"
  else
    sketchybar --set "$NAME" drawing=off
  fi
else
  if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --animate sin 10 \
      --set "$NAME" \
      y_offset=10 y_offset=0 \
      background.drawing=on

    sketchybar --set "$NAME" \
      display="$monitor" \
      drawing=on \
      label="$icons" \
      label.color="$BACKGROUND" \
      icon.color="$BACKGROUND" \
      background.color="$ACCENT_COLOR"
  else
    sketchybar --set "$NAME" \
      display="$monitor" \
      drawing=on \
      label="$icons" \
      background.drawing=off \
      label.color="$ACCENT_COLOR" \
      icon.color="$ACCENT_COLOR" \
      background.color="$TRANSPARENT"
  fi
fi
