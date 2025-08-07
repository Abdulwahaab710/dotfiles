#!/bin/sh

attr_wechat=(
  icon=":wechat:"
  icon.font="$FONT_ICON:Regular:16.0"
  icon.color=0xff1aad19
  click_script="open -a Wechat"
)

attr_qq=(
  icon=":qq:"
  icon.font="$FONT_ICON:Regular:16.0"
  icon.color=0xfff38ba8
  click_script="osascript -e 'tell application \"QQ\" to activate'"
)

sketchybar  -m    --add       item      WeChat        e                       \
                  --set                 WeChat        "${attr_wechat[@]}"     \
                                                                              \
                  --add       item      QQ            e                       \
                  --set                 QQ            "${attr_qq[@]}"