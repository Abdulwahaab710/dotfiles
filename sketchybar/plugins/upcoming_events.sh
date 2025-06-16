#!/bin/bash

sketchybar --set $NAME \
  icon=" "\
  click_script=""

# Get current time in seconds since epoch
current_time=$(date +%s)

# Get today and tomorrow's events from icalBuddy
events=$(icalBuddy -nc -npn eventsToday+1)

# Process line by line to find events with times
next_event=""
min_diff=999999999
current_event=""

while IFS= read -r line; do
    # Check if this is an event line (starts with bullet)
    if [[ "$line" =~ ^•[[:space:]] ]]; then
        # Extract event name (remove bullet)
        current_event=$(echo "$line" | sed 's/^•[[:space:]]*//')
    elif [[ "$line" =~ [[:space:]]*(today|tomorrow)[[:space:]]+at[[:space:]]+[0-9]+:[0-9]+[[:space:]]*(AM|PM) ]]; then
        # This line contains time information - use the last seen event name
        if [[ -n "$current_event" ]]; then
            start_time=$(echo "$line" | grep -o '[0-9]*:[0-9]*[[:space:]]*[AP]M' | head -1 | sed 's/[[:space:]]//g')
            day_indicator=$(echo "$line" | grep -o 'today\|tomorrow')

            if [[ -n "$start_time" && -n "$day_indicator" ]]; then
                # Convert to 24-hour format
                hour=$(echo "$start_time" | cut -d: -f1)
                minute=$(echo "$start_time" | cut -d: -f2 | sed 's/[AP]M//')

                if [[ "$start_time" =~ PM$ ]] && [[ "$hour" != "12" ]]; then
                    hour=$((hour + 12))
                elif [[ "$start_time" =~ AM$ ]] && [[ "$hour" == "12" ]]; then
                    hour="00"
                fi

                # Ensure proper formatting
                if [[ ${#hour} -eq 1 ]]; then
                    hour="0$hour"
                fi
                if [[ ${#minute} -eq 1 ]]; then
                    minute="0$minute"
                fi

                start_time_24="${hour}:${minute}"

                # Get the correct date
                if [[ "$day_indicator" == "today" ]]; then
                    event_date=$(date +%Y-%m-%d)
                else
                    event_date=$(date -j -v+1d +%Y-%m-%d)
                fi

                event_datetime="${event_date} ${start_time_24}:00"
                event_epoch=$(date -j -f "%Y-%m-%d %H:%M:%S" "$event_datetime" +%s 2>/dev/null)

                if [[ -n "$event_epoch" ]] && [[ $event_epoch -gt $current_time ]]; then
                    diff=$((event_epoch - current_time))
                    if [[ $diff -lt $min_diff ]]; then
                        min_diff=$diff

                        # Calculate hours and minutes
                        hours=$((diff / 3600))
                        minutes=$(((diff % 3600) / 60))

                        if [[ $hours -gt 0 ]]; then
                            time_until="In ${hours}h ${minutes}m"
                        else
                            time_until="In ${minutes}m"
                        fi

                        next_event="${current_event} (${start_time}) - ${time_until}"
                    fi
                fi
            fi
        fi
    fi
done <<< "$events"

if [[ -n "$next_event" ]]; then
    sketchybar --set $NAME \
      label="$next_event" \
      background.drawing=on \
      icon.padding_left=10 \
      label.padding_right=10 \
      icon=󰃰 \
      click_script=""
      # click_script="sketchybar --set $NAME label=\"\" background.drawing=off icon.padding_left=0 label.padding_right=0 icon=󰢠"
else
    sketchybar --set $NAME \
      label="No upcoming meetings" \
      background.drawing=off \
      icon.padding_left=0 \
      label.padding_right=0 \
      icon= \
      click_script=""
fi
