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

cat > "$tmp_dir/bin/date" <<'STUB'
#!/bin/bash
if [[ "$1" == "+%s" ]]; then
  printf '%s\n' 1000
elif [[ "$1" == "+%Y-%m-%d" ]]; then
  printf '%s\n' 2026-05-26
elif [[ "$1" == "+%a %d %b 􀐫 %I:%M %p" ]]; then
  printf '%s\n' "Tue 26 May 􀐫 03:00 PM"
elif [[ "$1" == "-j" && "$2" == "-v+1d" ]]; then
  printf '%s\n' 2026-05-27
elif [[ "$1" == "-j" && "$2" == "-f" ]]; then
  case "$4" in
    "2026-05-26 15:30:00") printf '%s\n' 4600 ;;
    "2026-05-26 16:00:00") printf '%s\n' 6400 ;;
    "2026-05-26 16:30:00") printf '%s\n' 8200 ;;
    "2026-05-26 17:00:00") printf '%s\n' 10000 ;;
    "2026-05-26 17:30:00") printf '%s\n' 11800 ;;
    "2026-05-26 18:05:00") printf '%s\n' 13900 ;;
    *) printf 'unexpected parsed datetime: %s\n' "$4" >&2; exit 1 ;;
  esac
else
  printf 'unexpected date invocation: %s\n' "$*" >&2
  exit 1
fi
STUB

cat > "$tmp_dir/bin/icalBuddy" <<'STUB'
#!/bin/bash
gap="$(printf '\342\200\257')"
if [[ " $* " == *" eventsToday+1 "* ]]; then
  if [[ "${ICALBUDDY_MULTIPLE_EVENTS:-}" == "true" ]]; then
    printf '• Security Sync\n    today at 3:30%sPM - 4:00%sPM\n' "$gap" "$gap"
    printf '• Design Review\n    today at 4:00%sPM - 4:30%sPM\n' "$gap" "$gap"
    printf '• Threat Model\n    today at 4:30%sPM - 5:00%sPM\n' "$gap" "$gap"
    printf '• Partner Sync\n    today at 5:00%sPM - 5:30%sPM\n' "$gap" "$gap"
    printf '• Office Hours\n    today at 5:30%sPM - 6:00%sPM\n' "$gap" "$gap"
    printf '• Asr prayer\n    today at 6:05%sPM - 6:35%sPM\n' "$gap" "$gap"
  else
    printf '• Security Sync\n    today at 3:30%sPM - 4:00%sPM\n' "$gap" "$gap"
  fi
  exit 0
fi
bullets=true
previous=""
for argument in "$@"; do
  if [[ "$previous" == "-b" && -z "$argument" ]]; then
    bullets=false
  fi
  previous="$argument"
done
if "$bullets"; then
  printf '• Security Sync\n    3:30%sPM - 4:00%sPM\n' "$gap" "$gap"
else
  printf 'Security Sync\n    3:30%sPM - 4:00%sPM\n' "$gap" "$gap"
fi
STUB

chmod +x "$tmp_dir/bin/sketchybar" "$tmp_dir/bin/date" "$tmp_dir/bin/icalBuddy"
export PATH="$tmp_dir/bin:$PATH"
export LC_ALL=C
export SKETCHYBAR_CALLS="$tmp_dir/sketchybar_calls"

: > "$SKETCHYBAR_CALLS"
ICALBUDDY_MULTIPLE_EVENTS=true SENDER=routine NAME=cron bash "$root_dir/sketchybar/plugins/upcoming_events.sh"
grep -F 'label=Security Sync (3:30PM) - In 1h 0m' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'cron.event.1 label=[3:30PM] Security Sync drawing=on' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'cron.event.2 label=[4:00PM] Design Review drawing=on' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'cron.event.3 label=[4:30PM] Threat Model drawing=on' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'cron.event.4 label=[5:00PM] Partner Sync drawing=on' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'cron.event.5 label=...and 2 more events drawing=on' "$SKETCHYBAR_CALLS" >/dev/null
! grep -F 'popup.drawing=toggle' "$SKETCHYBAR_CALLS" >/dev/null

: > "$SKETCHYBAR_CALLS"
SENDER=routine NAME=cron bash "$root_dir/sketchybar/plugins/upcoming_events.sh"
grep -F 'cron.event.1 label=[3:30PM] Security Sync drawing=on' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'cron.event.2 drawing=off' "$SKETCHYBAR_CALLS" >/dev/null
! grep -F 'click_script=' "$SKETCHYBAR_CALLS" >/dev/null
! grep -F 'popup.drawing=toggle' "$SKETCHYBAR_CALLS" >/dev/null

: > "$SKETCHYBAR_CALLS"
BAR_BORDER_COLOR=0xff494d64 POPUP_BACKGROUND_COLOR=0xff1e1e2e TEXT=0xffcad3f5 PLUGIN_DIR=/plugins bash "$root_dir/sketchybar/items/upcoming_events.sh"
grep -F 'click_script=sketchybar --set $NAME popup.drawing=toggle' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'popup.horizontal=off' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'popup.height=34' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'popup.background.border_color=0xff494d64' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'popup.background.color=0xff1e1e2e' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'icon.drawing=off' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'label.color=0xffcad3f5' "$SKETCHYBAR_CALLS" >/dev/null
grep -F 'background.drawing=off' "$SKETCHYBAR_CALLS" >/dev/null
! grep -F 'click_script=/plugins/upcoming_events.sh' "$SKETCHYBAR_CALLS" >/dev/null

: > "$SKETCHYBAR_CALLS"
NAME=calendar bash "$root_dir/sketchybar/plugins/calendar.sh"
grep -F 'calendar.event.1 label=[15:30] Security Sync drawing=on' "$SKETCHYBAR_CALLS" >/dev/null

printf 'calendar plugin regression tests passed\n'
