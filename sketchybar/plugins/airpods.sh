#!/bin/zsh

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
declare -A icons=(
  ["0x200E"]="􀪷"   # AirPods Pro 1st gen
  ["0x2014"]="􀪷"   # AirPods Pro 2nd gen
  ["0x2024"]="􀪷"   # AirPods Pro 3rd gen (USB-C)
  ["0x200F"]="􀟥"   # AirPods (standard)
  ["0x200A"]="􀺹"   # AirPods Max (Lightning)
  ["0x201F"]="􀺹"   # AirPods Max (USB-C)
  ["0x201D"]="􀑈"   # PowerBeats Pro 2
  ["0x2012"]="􀑈"   # Beats Fit Pro
)

# Left/right only icons per model type
declare -A icons_left=(
  ["pro"]="􀲍"
  ["standard"]="􀹬"
  ["max"]="􀺹"
  ["beats"]="􀑈"
)

declare -A icons_right=(
  ["pro"]="􀲎"
  ["standard"]="􀹭"
  ["max"]="􀺹"
  ["beats"]="􀑈"
)

get_model_type() {
  case "$1" in
    0x200E|0x2014|0x2024) echo "pro" ;;
    0x200F) echo "standard" ;;
    0x200A|0x201F) echo "max" ;;
    0x201D|0x2012) echo "beats" ;;
    *) echo "pro" ;;
  esac
}


battery_left="$(echo "$DEVICE_INFO" | jq -r '.device_batteryLevelLeft // empty')"
battery_right="$(echo "$DEVICE_INFO" | jq -r '.device_batteryLevelRight // empty')"
battery_case="$(echo "$DEVICE_INFO" | jq -r '.device_batteryLevelCase // empty')"
product_id="$(echo "$DEVICE_INFO" | jq -r '.device_productID // empty')"
model_type="$(get_model_type "$product_id")"

# Get icon from product ID, fallback to generic AirPods Pro
icon="${icons[$product_id]:-􀪷}"

# Override for single ear connected (left or right only)
if [ -z "$battery_left" ] && [ -n "$battery_right" ]; then
  icon="${icons_right[$model_type]:-$icon}"
elif [ -n "$battery_left" ] && [ -z "$battery_right" ]; then
  icon="${icons_left[$model_type]:-$icon}"
fi

# Build label with available battery info
label=""
[ -n "$battery_left" ] && label="$battery_left"
[ -n "$battery_right" ] && label="$label $battery_right"
[ -n "$battery_case" ] && label="$label 􀹬$battery_case"

# Final settings icon and text
sketchybar -m --set volume_icon   drawing=off \
              --set "$NAME"       drawing=on icon="$icon" label="$label"
