#!/bin/sh

sketchybar -m --set cpu.stats label="$(top -l 1 | grep "CPU usage" | awk '{ printf("%.0f%%", $3 + $5) }')"