#!/bin/sh

POPUP_OFF="sketchybar --set apple.logo popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

apple_logo=(
  icon=$APPLE
  icon.y_offset=1
  icon.font="$FONT_ICON:Black:26.0"
  icon.color=$WHITE
  icon.padding_left=14
  icon.padding_right=16
  padding_right=10
  label.drawing=off
  background.height=32
  background.corner_radius=24
  #background.color=0x00000000
  click_script="$POPUP_CLICK_SCRIPT"
)

apple_prefs=(
  icon=$PREFERENCES
  padding_left=15
  background.color=0x00000000
  label="Preferences"
  click_script="open -a 'System Preferences'; $POPUP_OFF"
)

apple_activity=(
  icon=$ACTIVITY
  padding_left=15
  background.color=0x00000000
  label="Activity"
  click_script="open -a 'Activity Monitor'; $POPUP_OFF"
)

apple_lock=(
  icon=$LOCK
  padding_left=15
  padding_right=15
  background.color=0x00000000
  label="Lock Screen"
  click_script="pmset displaysleepnow; $POPUP_OFF"
)

apple_restart=(
  icon=$RESTART
  padding_left=15
  background.color=0x331e1e2e
  label="Restart"
  click_script="osascript -e 'tell app \"System Events\" to restart'; $POPUP_OFF"
)

apple_shutdown=(
  icon=$SHUTDOWN
  padding_left=15
  padding_right=15
  background.color=0x331e1e2e
  label="Shut Down"
  click_script="osascript -e 'tell app \"System Events\" to shut down'; $POPUP_OFF"
)

sketchybar  -m  --add item apple.logo left                                \
                --set apple.logo "${apple_logo[@]}"                       \
                                                                      \
                --add item apple.prefs popup.apple.logo                   \
                --set apple.prefs "${apple_prefs[@]}"                     \
                                                                      \
                --add item apple.activity popup.apple.logo                \
                --set apple.activity "${apple_activity[@]}"               \
                                                                      \
                --add item apple.lock popup.apple.logo                    \
                --set apple.lock "${apple_lock[@]}"                        \
                                                                      \
                --add item apple.restart popup.apple.logo                \
                --set apple.restart "${apple_restart[@]}"                \
                                                                      \
                --add item apple.shutdown popup.apple.logo               \
                --set apple.shutdown "${apple_shutdown[@]}"
