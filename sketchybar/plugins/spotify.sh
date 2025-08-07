#!/bin/sh

# Allow override via first arg or env variable
SPOTIFY_DISPLAY_CONTROLS="${1:-false}"
COVER_PATH="/tmp/cover.jpg"
MAX_LABEL_LENGTH=35
# Optional control functions (disabled by default)
next () {
  osascript -e 'tell application "Spotify" to play next track'
  update
}

back () {
  osascript -e 'tell application "Spotify" to play previous track'
  update
}

play () {
  osascript -e 'tell application "Spotify" to playpause'
  update
}

repeat_toggle () {
  REPEAT=$(osascript -e 'tell application "Spotify" to get repeating')
  if [ "$REPEAT" = "false" ]; then
    sketchybar -m --set spotify.repeat icon.highlight=on
    osascript -e 'tell application "Spotify" to set repeating to true'
  else
    sketchybar -m --set spotify.repeat icon.highlight=off
    osascript -e 'tell application "Spotify" to set repeating to false'
  fi
}

shuffle_toggle () {
  SHUFFLE=$(osascript -e 'tell application "Spotify" to get shuffling')
  if [ "$SHUFFLE" = "false" ]; then
    sketchybar -m --set spotify.shuffle icon.highlight=on
    osascript -e 'tell application "Spotify" to set shuffling to true'
  else
    sketchybar -m --set spotify.shuffle icon.highlight=off
    osascript -e 'tell application "Spotify" to set shuffling to false'
  fi
}

truncate_text() {
  local text="$1"
  local max_length=${2:-$MAX_LABEL_LENGTH}
  if [ ${#text} -le "$max_length" ]; then
    echo "$text"
  else
    echo "${text:0:max_length}" | sed -E 's/\s+[[:alnum:]]*$//' | awk '{$1=$1};1' | sed 's/$/.../'
  fi
}

update() {
  local state
  state=$(osascript -e 'tell application "Spotify" to get player state' 2>/dev/null)

  if [ "$state" != "playing" ] && [ "$state" != "paused" ]; then
    sketchybar -m --set spotify.anchor drawing=off popup.drawing=off \
    exit 0
  fi
  # Set play or pause icon depending on state
  local play_icon=""
  if [ "$SPOTIFY_DISPLAY_CONTROLS" = "true" ]; then
    if [ "$state" = "playing" ]; then
      play_icon="􀊆"  # pause icon
    else
      play_icon="􀊄"  # play icon
    fi
  fi

  local track artist album cover_url
  track=$(osascript -e 'tell application "Spotify" to get name of current track')
  artist=$(osascript -e 'tell application "Spotify" to get artist of current track')
  album=$(osascript -e 'tell application "Spotify" to get album of current track')
  cover_url=$(osascript -e 'tell application "Spotify" to get artwork url of current track')
  
  # Download cover image with fallback
  if curl -s --max-time 5 "$cover_url" -o "$COVER_PATH"; then
    sketchybar -m --set spotify.cover background.image="$COVER_PATH" background.color=0x00000000
  else
    # fallback if download fails
    sketchybar -m --set spotify.cover background.image="" background.color=0x00000000
  fi

  track=$(truncate_text "$track" $((MAX_LABEL_LENGTH * 7/10)))
  artist=$(truncate_text "$artist")
  album=$(truncate_text "$album")
  
  sketchybar -m \
    --set spotify.title label="$track" \
    --set spotify.artist label="$artist" \
    --set spotify.album label="$album" \
    --set spotify.anchor drawing=on
  
  # Only update these if controls are enabled
  if [ "$SPOTIFY_DISPLAY_CONTROLS" = "true" ]; then
    sketchybar -m \
      --set spotify.shuffle icon.highlight=$shuffle \
      --set spotify.repeat icon.highlight=$repeat \
      --set spotify.play icon="$play_icon"
  fi
}

scroll() {
  local duration_ms position time duration
  duration_ms=$(osascript -e 'tell application "Spotify" to get duration of current track')
  duration=$((duration_ms / 1000))
  position=$(osascript -e 'tell application "Spotify" to get player position')
  time=${position%.*}

  sketchybar -m --animate linear 10 \
    --set spotify.state slider.percentage=$((time * 100 / duration)) \
                         icon="$(date -r $time +'%M:%S')" \
                         label="$(date -r $duration +'%M:%S')"
}

scrubbing() {
  local duration_ms duration target
  duration_ms=$(osascript -e 'tell application "Spotify" to get duration of current track')
  duration=$((duration_ms / 1000))
  target=$((duration * PERCENTAGE / 100))

  osascript -e "tell application \"Spotify\" to set player position to $target"
  sketchybar -m --set spotify.state slider.percentage=$PERCENTAGE
}

popup() {
  sketchybar -m --set spotify.anchor popup.drawing=$1
}

routine() {
  case "$NAME" in
    "spotify.state") scroll
    ;;
    *) update
    ;;
  esac
}

mouse_clicked () {
  case "$NAME" in
    "spotify.next") next
    ;;
    "spotify.back") back
    ;;
    "spotify.play") play
    ;;
    "spotify.shuffle") shuffle_toggle
    ;;
    "spotify.repeat") repeat_toggle
    ;;
    "spotify.state") scrubbing
    ;;
    *) exit
    ;;
  esac
}


case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "mouse.entered") 
    popup on
    update
  ;;
  "mouse.exited"|"mouse.exited.global") popup off
  ;;
  "routine") routine
  ;;
  "forced") exit 0
  ;;
  *) update
  ;;
esac