#!/bin/sh

INTERFACE="en0"
INTERVAL=1

read -r INITIAL_IN INITIAL_OUT <<<"$(netstat -ib | awk -v iface="$INTERFACE" '
  $1 == iface && $7 ~ /^[0-9]+$/ && $10 ~ /^[0-9]+$/ {
    bytes_in+=$7; bytes_out+=$10
  }
  END { print bytes_in, bytes_out }
')"

sleep $INTERVAL

read -r FINAL_IN FINAL_OUT <<<"$(netstat -ib | awk -v iface="$INTERFACE" '
  $1 == iface && $7 ~ /^[0-9]+$/ && $10 ~ /^[0-9]+$/ {
    bytes_in+=$7; bytes_out+=$10
  }
  END { print bytes_in, bytes_out }
')"

DOWN_BPS=$(( (FINAL_IN - INITIAL_IN) * 8 / INTERVAL ))
UP_BPS=$(( (FINAL_OUT - INITIAL_OUT) * 8 / INTERVAL ))

# 固定格式输出： "  0.00Mbps"
format_speed() {
  local BPS=$1
  awk -v bps="$BPS" 'BEGIN {
    speed = bps / 1000000
    printf " %5.2fMbps", speed
  }'
}

DOWN_FORMAT=$(format_speed "$DOWN_BPS")
UP_FORMAT=$(format_speed "$UP_BPS")

sketchybar -m \
  --set network.down label="$DOWN_FORMAT" \
  --set network.up   label="$UP_FORMAT"