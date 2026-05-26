#!/bin/bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT
mkdir -p "$tmp_dir/bin"

cat > "$tmp_dir/bin/sketchybar" <<'STUB'
#!/bin/bash
printf '%s\n' "$*" >> "$SKETCHYBAR_CALLS"
STUB

cat > "$tmp_dir/bin/system_profiler" <<'STUB'
#!/bin/bash
cat "$SYSTEM_PROFILER_FIXTURE"
STUB

cat > "$tmp_dir/bin/blueutil" <<'STUB'
#!/bin/bash
if [[ "$1" == "--paired" ]]; then
  cat "$BLUEUTIL_FIXTURE"
  exit 0
fi
printf '%s\n' "$*" >> "$BLUEUTIL_CALLS"
STUB

chmod +x "$tmp_dir/bin/sketchybar" "$tmp_dir/bin/system_profiler" "$tmp_dir/bin/blueutil"
export PATH="$tmp_dir/bin:$PATH"
export SKETCHYBAR_CALLS="$tmp_dir/sketchybar_calls"
export BLUEUTIL_CALLS="$tmp_dir/blueutil_calls"
export GREEN=0xffa6da95
export GREY=0xff939ab7
export MAROON=0xffee99a0
export TEXT=0xffcad3f5

cat > "$tmp_dir/connected_profile.json" <<'JSON'
{"SPBluetoothDataType":[{"device_connected":[{"AirPods Max - Find My":{"device_address":"70:F9:4A:97:3A:1D","device_minorType":"Headphones","device_productID":"0x201F","device_batteryLevelMain":"45%"}},{"Magic Trackpad":{"device_address":"10:94:BB:AD:38:49","device_minorType":"Magic Trackpad","device_productID":"0x0265"}}],"device_not_connected":[{"AirPods Pro":{"device_address":"E8:85:4B:8F:17:A0","device_minorType":"Headphones","device_productID":"0x200E"}},{"Beats Fit Pro":{"device_address":"F4:D4:88:CB:8E:99","device_minorType":"Headphones","device_productID":"0x2012"}},{"WH-1000XM3":{"device_address":"CC:98:8B:49:CA:9D","device_minorType":"Headset","device_productID":"0x0CD3"}},{"Keychron K12":{"device_address":"DC:2C:26:07:B5:B1","device_minorType":"Keyboard","device_productID":"0x024F"}}]}]}
JSON
cat > "$tmp_dir/connected_paired.json" <<'JSON'
[{"address":"70-f9-4a-97-3a-1d","name":"AirPods Max","connected":true,"paired":true},{"address":"e8-85-4b-8f-17-a0","name":"AirPods Pro","connected":false,"paired":true},{"address":"f4-d4-88-cb-8e-99","name":"Beats Fit Pro","connected":false,"paired":true},{"address":"cc-98-8b-49-ca-9d","name":"WH-1000XM3","connected":false,"paired":true},{"address":"dc-2c-26-07-b5-b1","name":"Keychron K12","connected":false,"paired":true},{"address":"10-94-bb-ad-38-49","name":"Magic Trackpad","connected":true,"paired":true}]
JSON

export SYSTEM_PROFILER_FIXTURE="$tmp_dir/connected_profile.json"
export BLUEUTIL_FIXTURE="$tmp_dir/connected_paired.json"
: > "$SKETCHYBAR_CALLS"
NAME=headphones zsh "$root_dir/sketchybar/plugins/airpods.sh"
grep -F -- '--set volume_icon drawing=off --set headphones drawing=on icon=􀺹 label=45%' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'headphones.device.1 icon=􀺹 icon.color=0xffa6da95 label=AirPods Max · Connected label.color=0xffa6da95' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'blueutil --disconnect "70:F9:4A:97:3A:1D"' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'headphones.device.2 icon=􀪷 icon.color=0xff939ab7 label=AirPods Pro · Connect' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'blueutil --connect "E8:85:4B:8F:17:A0"' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'headphones.device.3 icon=􀹭 icon.color=0xff939ab7 label=Beats Fit Pro · Connect' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'headphones.device.4 icon=􀑈 icon.color=0xff939ab7 label=WH-1000XM3 · Connect' "$SKETCHYBAR_CALLS" >/dev/null
! grep -F 'Keychron K12' "$SKETCHYBAR_CALLS" >/dev/null
! grep -F 'Magic Trackpad' "$SKETCHYBAR_CALLS" >/dev/null

audio_profile="$tmp_dir/disconnected_profile.json"
cat > "$audio_profile" <<'JSON'
{"SPBluetoothDataType":[{"device_not_connected":[{"AirPods Pro":{"device_address":"E8:85:4B:8F:17:A0","device_minorType":"Headphones","device_productID":"0x200E"}}]}]}
JSON
cat > "$tmp_dir/disconnected_paired.json" <<'JSON'
[{"address":"e8-85-4b-8f-17-a0","name":"AirPods Pro","connected":false,"paired":true}]
JSON
export SYSTEM_PROFILER_FIXTURE="$audio_profile"
export BLUEUTIL_FIXTURE="$tmp_dir/disconnected_paired.json"
: > "$SKETCHYBAR_CALLS"
NAME=headphones zsh "$root_dir/sketchybar/plugins/airpods.sh"
grep -F -- '--set volume_icon drawing=on --set headphones drawing=on icon=􀑈 icon.color=0xff939ab7 label= label.drawing=off' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'headphones.device.1 icon=􀪷 icon.color=0xff939ab7 label=AirPods Pro · Connect' "$SKETCHYBAR_CALLS" >/dev/null

: > "$SKETCHYBAR_CALLS"
FONT_ICON=font MAROON=0xffee99a0 BAR_BORDER_COLOR=0xff494d64 POPUP_BACKGROUND_COLOR=0xff1e1e2e TEXT=0xffcad3f5 PLUGIN_DIR=/plugins bash "$root_dir/sketchybar/items/airpods.sh"
grep -F 'click_script=sketchybar --set $NAME popup.drawing=toggle' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'popup.horizontal=off' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'popup.height=34' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'headphones.device.1 popup.headphones' "$SKETCHYBAR_CALLS" >/dev/null

printf 'airpods plugin regression tests passed\n'
