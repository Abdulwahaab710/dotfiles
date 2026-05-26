#!/bin/zsh

set -euo pipefail

green="${GREEN:-0xffa6da95}"
grey="${GREY:-0xff939ab7}"
maroon="${MAROON:-0xffee99a0}"
max_devices=8

get_icon() {
  case "$1" in
    0x200E|0x2014|0x2024) print -r -- "􀪷" ;;
    0x200F) print -r -- "􀟥" ;;
    0x200A|0x201F) print -r -- "􀺹" ;;
    0x2012) print -r -- "􀹭" ;;
    0x201D) print -r -- "􀑈" ;;
    *) print -r -- "􀑈" ;;
  esac
}

get_model_type() {
  case "$1" in
    0x200E|0x2014|0x2024) print -r -- "pro" ;;
    0x200F) print -r -- "standard" ;;
    0x200A|0x201F) print -r -- "max" ;;
    0x2012) print -r -- "beats" ;;
    *) print -r -- "generic" ;;
  esac
}

get_side_icon() {
  case "$1:$2" in
    left:pro) print -r -- "􀲍" ;;
    right:pro) print -r -- "􀲎" ;;
    left:standard) print -r -- "􀹬" ;;
    right:standard) print -r -- "􀹭" ;;
    left:max|right:max) print -r -- "􀺹" ;;
    left:beats|right:beats) print -r -- "􀹭" ;;
    *) print -r -- "$3" ;;
  esac
}

get_single_battery() {
  osascript -l JavaScript - "$1" 2>/dev/null <<'JXA'
ObjC.import('IOBluetooth')
function run(argv) {
  const device = $.IOBluetoothDevice.withAddressString(argv[0].replace(/:/g, '-'))
  if (!device) return ''
  return Number(device.batteryPercentSingle) + '%'
}
JXA
}

profile_json="$(system_profiler SPBluetoothDataType -json -detailLevel basic 2>/dev/null || print -r -- '{"SPBluetoothDataType":[{}]}')"
paired_json="$(blueutil --paired --format json 2>/dev/null || print -r -- '[]')"
if ! jq -e . >/dev/null 2>&1 <<< "$profile_json"; then
  profile_json='{"SPBluetoothDataType":[{}]}'
fi
if ! jq -e . >/dev/null 2>&1 <<< "$paired_json"; then
  paired_json='[]'
fi

audio_devices="$(jq -rcn --argjson profile "$profile_json" --argjson paired "$paired_json" '
  ($paired | map({key: (.address | ascii_downcase | gsub("-"; ":")), value: .}) | from_entries) as $paired_by_address
  | [
      (($profile.SPBluetoothDataType[0].device_connected // []) + ($profile.SPBluetoothDataType[0].device_not_connected // []))[]?
      | to_entries[]
      | (.value.device_address // "" | ascii_downcase) as $address
      | select($address != "")
      | select(.value.device_minorType == "Headphones" or .value.device_minorType == "Headset")
      | select(($paired_by_address[$address].paired // false) == true)
      | {
          name: ($paired_by_address[$address].name // .key),
          address: .value.device_address,
          product_id: (.value.device_productID // ""),
          connected: (($paired_by_address[$address].connected // false) == true),
          detail: .value
        }
    ]
  | sort_by([if .connected then 0 else 1 end, (.name | ascii_downcase)])
  | .[]
')"

connected_device="$(jq -sc 'map(select(.connected))[0] // empty' <<< "$audio_devices")"
if [[ -z "$connected_device" ]]; then
  sketchybar -m \
    --set volume_icon drawing=on \
    --set "$NAME" drawing=on icon="􀑈" icon.color="$grey" label="" label.drawing=off
else
  detail="$(jq -c '.detail' <<< "$connected_device")"
  battery_left="$(jq -r '.device_batteryLevelLeft // empty' <<< "$detail")"
  battery_right="$(jq -r '.device_batteryLevelRight // empty' <<< "$detail")"
  battery_case="$(jq -r '.device_batteryLevelCase // empty' <<< "$detail")"
  battery_main="$(jq -r '.device_batteryLevelMain // .device_batteryLevel // empty' <<< "$detail")"
  device_address="$(jq -r '.address' <<< "$connected_device")"
  product_id="$(jq -r '.product_id' <<< "$connected_device")"
  model_type="$(get_model_type "$product_id")"
  if [[ "$model_type" == "max" && -z "$battery_main" && -n "$device_address" ]]; then
    battery_main="$(get_single_battery "$device_address" || true)"
  fi
  icon="$(get_icon "$product_id")"
  if [[ -z "$battery_left" && -n "$battery_right" ]]; then
    icon="$(get_side_icon right "$model_type" "$icon")"
  elif [[ -n "$battery_left" && -z "$battery_right" ]]; then
    icon="$(get_side_icon left "$model_type" "$icon")"
  fi
  label=""
  [[ "$model_type" == "max" && -n "$battery_main" ]] && label="$battery_main"
  [[ -n "$battery_left" ]] && label="$battery_left"
  [[ -n "$battery_right" ]] && label="$label $battery_right"
  [[ -n "$battery_case" ]] && label="$label 􀹬$battery_case"
  label_drawing=off
  [[ -n "$label" ]] && label_drawing=on
  sketchybar -m \
    --set volume_icon drawing=off \
    --set "$NAME" drawing=on icon="$icon" label="$label" label.drawing="$label_drawing" icon.color="$maroon"
fi

row=1
while IFS= read -r device; do
  [[ -n "$device" ]] || continue
  (( row <= max_devices )) || break
  device_name="$(jq -r '.name' <<< "$device")"
  address="$(jq -r '.address' <<< "$device")"
  product_id="$(jq -r '.product_id' <<< "$device")"
  icon="$(get_icon "$product_id")"
  if [[ "$(jq -r '.connected' <<< "$device")" == "true" ]]; then
    color="$green"
    state_label="Connected"
    action="disconnect"
  else
    color="$grey"
    state_label="Connect"
    action="connect"
  fi
  sketchybar --set "${NAME}.device.$row" \
    icon="$icon" \
    icon.color="$color" \
    label="$device_name · $state_label" \
    label.color="$color" \
    drawing=on \
    click_script="blueutil --$action \"$address\" && sketchybar --set headphones popup.drawing=off --trigger bluetooth_change"
  (( row++ ))
done <<< "$audio_devices"

if [[ $row -eq 1 ]]; then
  sketchybar --set "${NAME}.device.1" \
    icon="􀑈" \
    icon.color="$grey" \
    label="No paired audio devices" \
    label.color="$grey" \
    drawing=on \
    click_script=""
  row=2
fi
while (( row <= max_devices )); do
  sketchybar --set "${NAME}.device.$row" drawing=off click_script=""
  (( row++ ))
done
