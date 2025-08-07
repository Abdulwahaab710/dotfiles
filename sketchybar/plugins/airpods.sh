#!/bin/sh

set -euo pipefail

# Get connected Bluetooth headset devices (type is Headphones)
DEVICE_INFO="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null |
  jq -rc '.SPBluetoothDataType[0].device_connected[] |
          select( .[] | .device_minorType == "Headphones") |
          .[]' 2>/dev/null || echo '')"

# When no headphones are connected, the battery icon is hidden and the default volume icon is displayed.
if [ -z "$DEVICE_INFO" ]; then
  sketchybar -m \
    --set "$NAME" drawing=off \
    --set volume_icon drawing=on
  exit 0
fi

# Source: https://theapplewiki.com/wiki/Bluetooth_PIDs
icons=(
  ["0x201D"] = "", # powerbeats pro 2
  ["0x200E"] = "", # airpods pro 1
  ["0x2014"] = "", # airpods pro 2
  ["0x2024"] = "", # airpods pro 3
)


battery_left="$(echo "$DEVICE_INFO" | jq -r '.device_batteryLevelLeft // empty')"
battery_right="$(echo "$DEVICE_INFO" | jq -r '.device_batteryLevelRight // empty')"
battery_case="$(echo "$DEVICE_INFO" | jq -r '.device_batteryLevelCase // empty')"

# Settings icon, the default is AirPods (both left and right have power)
icon="􀪷"
[ -z "$battery_left" ] && icon="􀲍"
[ -z "$battery_right" ] && icon="􀲎"

# When splicing labels, empty battery will be skipped
label="->$battery_left $battery_right"
[ -n "$battery_case" ] && label="$label 􀹬$battery_case"

# Final settings icon and text
sketchybar -m --set volume_icon   drawing=off \
              --set "$NAME"       drawing=on icon="$icon" label="$label"
