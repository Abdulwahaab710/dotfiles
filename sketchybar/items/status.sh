#!/bin/sh

attr_cpu_percent=(
	label.font="$FONT_LABEL:Heavy:12"
	label=CPU%
	label.color="$LABEL_COLOR"
	icon="$CPU"
	icon.color="$BLUE"
	update_freq=3
	script="$PLUGIN_DIR/status/cpu.sh"
	#click_script="sketchybar --set cpu.stats popup.drawing=toggle"
)


attr_memory=(
  label.font="$FONT_LABEL:Heavy:12"
	label.color="$TEXT"
	icon="$MEMORY"
	icon.font="$FONT_LABEL:Bold:16.0"
	icon.color="$GREEN"
	update_freq=3
	script="$PLUGIN_DIR/status/memory.sh"
)


attr_disk=(
	label.font="$FONT_LABEL:Heavy:12"
	label.color="$TEXT"
	icon="$DISK"
	icon.font="$FONT_LABEL:Bold:16"
	icon.color="$MAROON"
	update_freq=60
	script="$PLUGIN_DIR/status/disk.sh"
)


attr_network_down=(
	icon="$NETWORK_DOWN"
	icon.font="$FONT_LABEL:Bold:13.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	y_offset=-7
	label="0.00Mbps"
	label.font="$FONT_LABEL:Heavy:10"
	label.color="$TEXT"
	update_freq=2
	background.color=0x00000000
)

attr_network_up=(
	icon="$NETWORK_UP"
	icon.font="$FONT_LABEL:Bold:13.0"
	icon.color="$GREEN"
	icon.highlight_color="$BLUE"
	y_offset=7
	label="0.00Mbps"
	label.font="$FONT_LABEL:Heavy:10"
	label.color="$TEXT"
	update_freq=2
	background.padding_left=-69
	script="$PLUGIN_DIR/status/network.sh"
	background.color=0x00000000
)



attr_system_status=(
	icon=
	icon.font="$FONT_LABEL:Regular:16.0"
	icon.padding_right=10
	background.corner_radius=7
	background.padding_right=10
  label.drawing=off
	label.padding_right=10
	icon.color="$TEXT"
  updates=on
  script="$PLUGIN_DIR/status.sh"
)

sketchybar	-m	    --add event 				  hide_stats   					                                \
           					--add event 				  show_stats 					                                  \
           					--add event 				  toggle_stats 																					\
																																																\
										--add         item    separator       left                                 \
										--set                 separator       "${attr_system_status[@]}"            \
										--subscribe        	  separator       mouse.clicked                         \
																																																\
										--add         item    cpu.stats       left 					                      \
										--set                 cpu.stats       "${attr_cpu_percent[@]}"              \
																																																\
																																																\
										--add         item    memory          left 		                            \
										--set                 memory          "${attr_memory[@]}"                   \
																																																\
										--add         item    disk            left 		                            \
										--set                 disk            "${attr_disk[@]}"                     \
																																																\
										--add         item    network.down    left 						                    \
										--set                 network.down    "${attr_network_down[@]}" 	          \
																																																\
										--add         item    network.up      left 							                  \
										--set                 network.up      "${attr_network_up[@]}"


# sketchybar    --add   bracket  system_status  separator  cpu.stats  memory  disk  network.down  network.up 
#               #--set   system_status \
#                #       background.color=0x33ffffff 
