#!/usr/bin/env sh


# BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
# CHARGING=$(pmset -g batt | grep 'AC Power')
#
# sketchybar  -m --add item battery right
#
# if [[ ${CHARGING} != "" ]]; then
#   # sketchybar -m --set battery icon=""
#   #                             label="${BATT_PERCENT}%"
#   sketchybar -m --set battery label="PWR: ${BATT_PERCENT}%" \
#                               icon.color=0xff989898 \
#                               update_freq=1 \
#                               icon.font="$FONT:Black:16.0"
#   exit 0
# fi
#
# case ${BATT_PERCENT} in
#     100) ICON=$BATTERY_100 ;;
#     9[0-9]) ICON=$BATTERY_90 ;;
#     8[0-9]) ICON=$BATTERY_80 ;;
#     7[0-9]) ICON=$BATTERY_70 ;;
#     6[0-9]) ICON=$BATTERY_60 ;;
#     5[0-9]) ICON=$BATTERY_50 ;;
#     4[0-9]) ICON=$BATTERY_40 ;;
#     3[0-9]) ICON=$BATTERY_30 ;;
#     2[0-9]) ICON=$BATTERY_30 ;;
#     1[0-9]) ICON=$BATTERY_10 ;;
#     *) ICON=""
# esac
#
# echo $ICON
#
# # sketchybar -m --set battery icon=$ICON \
# #                             label="${BATT_PERCENT}%"
# sketchybar -m --set battery label="BATT: ${BATT_PERCENT}%" \
#                             icon.color=0xff989898 \
#                             update_freq=3 \
#                             icon.font="$FONT:Black:16.0"

sketchybar --add item battery right                      \
           --set battery script="$PLUGIN_DIR/battery.sh" \
                         update_freq=10                  \
           --subscribe battery system_woke

