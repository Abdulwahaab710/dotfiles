#!/bin/sh
# ────────────────────────────────────
# ▸ Toggle: Display Playback Controls
# ────────────────────────────────────
SPOTIFY_DISPLAY_CONTROLS=true  

# ────────────────────────────────────
# ▸ Configuration
# ────────────────────────────────────


SPOTIFY_EVENT="com.spotify.client.PlaybackStateChanged"
POPUP_SCRIPT="sketchybar -m --set spotify.anchor popup.drawing=toggle"

# Dynamic values based on toggle
POPUP_HEIGHT=$([ "$SPOTIFY_DISPLAY_CONTROLS" = false ] && echo 85 || echo 120)
IMAGE_SCALE=$([ "$SPOTIFY_DISPLAY_CONTROLS" = false ] && echo 0.10 || echo 0.15)
Y_OFFSET=$([ "$SPOTIFY_DISPLAY_CONTROLS" = false ] && echo -25 || echo -5)

# ────────────────────────────────────
# ▸ Items
# ────────────────────────────────────

spotify_anchor=(
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  click_script="$POPUP_SCRIPT"
  popup.horizontal=on
  popup.align=center
  popup.height=$POPUP_HEIGHT
  icon=􁒙
  icon.font="$FONT:Regular:25.0"
  label.drawing=off
  drawing=off
  y_offset=2
)

spotify_cover=(
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  click_script="open -a 'Spotify'; $POPUP_SCRIPT"
  label.drawing=off
  icon.drawing=off
  padding_left=12
  padding_right=10
  background.image.scale=$IMAGE_SCALE
  background.image.drawing=on
  background.drawing=on
)

spotify_title=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  width=0
  label.font="$FONT:Heavy:15.0"
  y_offset=$((50 + Y_OFFSET))
)

spotify_artist=(
  icon.drawing=off
  y_offset=$((30 + Y_OFFSET))
  padding_left=0
  padding_right=0
  width=0
  label.font="$FONT:Regular:13.0"
  label.color=$SECONDARY_COLOR
)

spotify_album=(
  icon.drawing=off
  padding_left=0
  padding_right=0
  y_offset=$((15 + Y_OFFSET))
  width=0
  label.font="$FONT:Regular:13.0"
  label.color=$TERTIARY_COLOR
)

ICON_WIDTH=50
LABEL_WIDTH=50
SLIDER_WIDTH=100

STATE_WIDTH=$([ "$SPOTIFY_DISPLAY_CONTROLS" = true ] && echo 0 || echo $((ICON_WIDTH + LABEL_WIDTH + SLIDER_WIDTH)))

spotify_state=(
  icon.drawing=on
  icon.font="$FONT:Light Italic:10.0"
  icon.width=$ICON_WIDTH
  icon="00:00"
  label.drawing=on
  label.font="$FONT:Light Italic:10.0"
  label.width=$LABEL_WIDTH
  label="00:00"
  label.padding_left=20
  y_offset=$((Y_OFFSET))
  width=$STATE_WIDTH
  slider.background.height=6
  slider.background.corner_radius=3
  slider.background.color=$BACKGROUND_BORDER
  slider.highlight_color=$ACCENT_COLOR
  slider.percentage=0
  slider.width=$SLIDER_WIDTH
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  update_freq=1
  updates=when_shown
)

# ────────────────────────────────────
# ▸ Optional Controls
# ────────────────────────────────────

CONTROLS_Y_OFFSET=$((-30 + Y_OFFSET))

spotify_shuffle=(
  icon=􀊝
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$DISABLED_COLOR
  icon.highlight_color=$BACKGROUND
  label.drawing=off
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"

  y_offset=$CONTROLS_Y_OFFSET
)

spotify_back=(
  icon=􀊎
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$BACKGROUND
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  label.drawing=off
  y_offset=$CONTROLS_Y_OFFSET
)

spotify_play=(
  icon=􀊄
  background.height=40
  background.corner_radius=20
  width=40
  align=center
  background.color=$BACKGROUND
  background.border_color=$BACKGROUND_BORDER
  background.border_width=1
  background.drawing=on
  icon.padding_left=4
  icon.padding_right=4
  icon.color=$ACCENT_COLOR
  updates=on
  label.drawing=off
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

spotify_next=(
  icon=􀊐
  icon.padding_left=5
  icon.padding_right=5
  icon.color=$BACKGROUND
  label.drawing=off
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

spotify_repeat=(
  icon=􀊞
  icon.highlight_color=$BACKGROUND
  icon.padding_left=5
  icon.padding_right=10
  icon.color=$DISABLED_COLOR
  label.drawing=off
  script="$PLUGIN_DIR/spotify.sh $SPOTIFY_DISPLAY_CONTROLS"
  y_offset=$CONTROLS_Y_OFFSET
)

spotify_controls=(
  background.color=$ACCENT_COLOR
  background.corner_radius=11
  background.drawing=on
  y_offset=$CONTROLS_Y_OFFSET
)

# ────────────────────────────────────
# ▸ SketchyBar Setup
# ────────────────────────────────────

sketchybar --add event spotify_change $SPOTIFY_EVENT             \
           --add item spotify.anchor e                      \
           --set spotify.anchor "${spotify_anchor[@]}"           \
           --subscribe spotify.anchor mouse.entered mouse.exited \
                                     mouse.exited.global         \
                                     spotify_init                \
                                                                 \
           --add item spotify.cover popup.spotify.anchor         \
           --set spotify.cover "${spotify_cover[@]}"             \
                                                                 \
           --add item spotify.title popup.spotify.anchor         \
           --set spotify.title "${spotify_title[@]}"             \
                                                                 \
           --add item spotify.artist popup.spotify.anchor        \
           --set spotify.artist "${spotify_artist[@]}"           \
                                                                 \
           --add item spotify.album popup.spotify.anchor         \
           --set spotify.album "${spotify_album[@]}"             \
                                                                 \
           --add slider spotify.state popup.spotify.anchor       \
           --set spotify.state "${spotify_state[@]}"             \

# ────────────────────────────────────
# ▸ Conditionally Add Controls
# ────────────────────────────────────

if [ "$SPOTIFY_DISPLAY_CONTROLS" = true ]; then
  sketchybar --add item spotify.shuffle popup.spotify.anchor       \
             --set spotify.shuffle "${spotify_shuffle[@]}"         \
             --subscribe spotify.shuffle mouse.clicked             \
                                                                   \
             --add item spotify.back popup.spotify.anchor          \
             --set spotify.back "${spotify_back[@]}"               \
             --subscribe spotify.back mouse.clicked                \
                                                                   \
             --add item spotify.play popup.spotify.anchor          \
             --set spotify.play "${spotify_play[@]}"               \
             --subscribe spotify.play mouse.clicked                \
                                                                   \
             --add item spotify.next popup.spotify.anchor          \
             --set spotify.next "${spotify_next[@]}"               \
             --subscribe spotify.next mouse.clicked                \
                                                                   \
             --add item spotify.repeat popup.spotify.anchor        \
             --set spotify.repeat "${spotify_repeat[@]}"           \
             --subscribe spotify.repeat mouse.clicked              \
                                                                   \
             --add item spotify.spacer popup.spotify.anchor        \
             --set spotify.spacer width=5                          \
                                                                   \
             --add bracket spotify.controls spotify.shuffle        \
                                            spotify.back           \
                                            spotify.play           \
                                            spotify.next           \
                                            spotify.repeat         \
             --set spotify.controls "${spotify_controls[@]}"
fi

# ────────────────────────────────────
# ▸ Trigger Initial Update
# ────────────────────────────────────

sketchybar --trigger spotify_init