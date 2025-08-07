#!/bin/sh

# 获取详细数据
read -r USER SYS IDLE <<<$(top -l 1 | grep "^CPU" | awk -F'[:,%]+' '{ printf("%s %s %s", $3, $5, $7) }')
LOAD=$(sysctl -n vm.loadavg | awk '{ printf "Load: %.2f %.2f %.2f", $1, $2, $3 }')

sketchybar --remove '/^cpu\.stats\.popup\..*/' > /dev/null 2>&1

# 添加 Header
sketchybar --add item cpu.stats.popup.header popup.cpu.stats \
  --set cpu.stats.popup.header \
    label="🧠 CPU Detail" \
    label.font="$FONT_LABEL:Bold:14" \
    label.color="$LABEL_COLOR" \
    padding_left=10 padding_right=10 \
    background.drawing=off

# 添加各项
sketchybar --add item cpu.stats.popup.usage popup.cpu.stats \
  --set cpu.stats.popup.usage \
    label="User: $USER%   System: $SYS%   Idle: $IDLE%" \
    label.font="$FONT_LABEL:Medium:12" \
    label.color="$LABEL_COLOR" \
    padding_left=10 padding_right=10

sketchybar --add item cpu.stats.popup.load popup.cpu.stats \
  --set cpu.stats.popup.load \
    label="$LOAD" \
    label.font="$FONT_LABEL:Medium:12" \
    label.color="$BLUE" \
    padding_left=10 padding_right=10