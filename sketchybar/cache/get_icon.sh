#!/bin/sh

CACHE_DIR="$HOME/.config/sketchybar/cache"
CACHE_FILE="$CACHE_DIR/icons.txt"
[ ! -f "$CACHE_FILE" ] && touch $CACHE_FILE

source "$CACHE_DIR/icon_map.sh"

APP_NAME="$1"
CACHED_ICON=$(rg -F "$APP_NAME|" "$CACHE_FILE" | cut -d '|' -f2)

if [ -n "$CACHED_ICON" ]; then
  echo "$CACHED_ICON"
  exit 0
fi

__icon_map "$APP_NAME"

if [ -n "$icon_result" ]; then
  echo "$APP_NAME|$icon_result" >>"$CACHE_FILE"
fi

echo "$icon_result"