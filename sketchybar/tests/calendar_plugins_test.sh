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
elif [[ "$1" == "-j" && "$2" == "-f" && "$4" == "2026-05-26 15:30:00" ]]; then
  printf '%s\n' 4600
else
  printf 'unexpected date invocation: %s\n' "$*" >&2
  exit 1
fi
STUB

cat > "$tmp_dir/bin/icalBuddy" <<'STUB'
#!/bin/bash
gap="$(printf '\342\200\257')"
if [[ " $* " == *" eventsToday+1 "* ]]; then
  printf '• Security Sync\n    today at 3:30%sPM - 4:00%sPM\n' "$gap" "$gap"
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
NAME=cron bash "$root_dir/sketchybar/plugins/upcoming_events.sh"
grep -F 'label=Security Sync (3:30PM) - In 1h 0m' "$SKETCHYBAR_CALLS" >/dev/null

: > "$SKETCHYBAR_CALLS"
NAME=calendar bash "$root_dir/sketchybar/plugins/calendar.sh"
grep -F 'calendar.event.1 label=[15:30] Security Sync drawing=on' "$SKETCHYBAR_CALLS" >/dev/null

printf 'calendar plugin regression tests passed\n'
