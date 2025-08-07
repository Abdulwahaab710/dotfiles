  #!/bin/sh

  
  attr_calendar=(
    icon=􀉉
    icon.color=0xfff6c177
    icon.padding_left=10
    icon.padding_right=8
    icon.y_offset=1
    label="$(LC_TIME=en_US.UTF-8 date '+%a %d %b 􀐫 %H:%M')"
    label.color=0xffe0def4
    label.font.size="Maple Mono NF CN:Semibold:14"
    label.padding_right=12

    background.color=0xff2a273f
    background.height=28
    background.corner_radius=15
    background.border_width=2
    background.border_color=0xff393552

    padding_left=4
    padding_right=4

    script="$PLUGIN_DIR/calendar.sh"
    update_freq=60

    popup.horizontal=on
    popup.align=center
    popup.height=135
    popup.background.border_width=2
    popup.background.corner_radius=6
    popup.background.border_color=0xffd0d0d0
    popup.background.color=0xfffafafa
  )


  sketchybar    -m    --add     item    calendar    right                   \
                      --set             calendar    "${attr_calendar[@]}"   \
                      --subscribe       calendar system_woke mouse.clicked mouse.entered mouse.exited mouse.exited.global