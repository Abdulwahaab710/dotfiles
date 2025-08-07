#!/bin/sh


update() {
	IP_ADDRESS=$(scutil --nwi | /opt/homebrew/bin/rg address | sed 's/.*://' | tr -d ' ' | head -1)
	IS_VPN=$(scutil --nwi | /opt/homebrew/bin/rg -m1 'utun' | awk '{ print $1 }')

	if [[ $IS_VPN != "" ]]; then
		ICON=􀤆
		LABEL="VPN"
	elif [[ $IP_ADDRESS != "" ]]; then
		ICON=􀙇
		LABEL=$IP_ADDRESS
	else
		ICON=􀙈
		LABEL="Not Connected"
	fi

	sketchybar --set $NAME \
		icon=$ICON \
		label="$LABEL"
}

click() {
  CURRENT_WIDTH="$(sketchybar --query $NAME | jq -r .label.width)"

  WIDTH=0
  if [ "$CURRENT_WIDTH" -eq "0" ]; then
    WIDTH=dynamic
  fi

  sketchybar --animate sin 20 --set $NAME label.width="$WIDTH"
}

case "$SENDER" in
  "wifi_change") update
  ;;
  "mouse.clicked") click
  ;;
esac
