#!/bin/sh

stats=(
	cpu.stats
	memory
	disk
	network.down
  network.up
)

hide_stats() {
	args=()
	for item in "${stats[@]}"; do
		args+=(--set "$item" drawing=off)
	done

	sketchybar "${args[@]}" \
		--set separator   icon=
}

show_stats() {
	args=()
	for item in "${stats[@]}"; do
		args+=(--set "$item" drawing=on)
	done

	sketchybar "${args[@]}" \
		--set separator   icon=
}


state=$(sketchybar --query separator | jq -r .icon.value)

case $state in
"")
  show_stats
  ;;
"")
  hide_stats
  ;;
esac

