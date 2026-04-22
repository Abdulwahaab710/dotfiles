#!/bin/bash

# Always update the time label
sketchybar --set "${NAME:-calendar}" label="$(LC_TIME=en_US.UTF-8 date '+%a %d %b 􀐫 %I:%M %p')"

# When called via click_script (no $SENDER), populate popup and toggle
# When called via subscription ($SENDER is set), just update time above
if [ -z "$SENDER" ]; then
    current_time=$(date +%s)

    # Fetch today's events from icalBuddy
    events=$(icalBuddy -nc -npn -b "" eventsToday 2>/dev/null)

    # Arrays to store upcoming events
    declare -a event_times=()
    declare -a event_names=()

    current_event=""

    # Parse events
    while IFS= read -r line; do
        # Event line starts with bullet
        if [[ "$line" =~ ^•[[:space:]] ]]; then
            current_event=$(echo "$line" | sed 's/^•[[:space:]]*//')
        # Time line contains "at HH:MM AM/PM"
        elif [[ "$line" =~ at[[:space:]]+[0-9]+:[0-9]+[[:space:]]*(AM|PM) ]]; then
            if [[ -n "$current_event" && ! "$current_event" =~ ^\[PLACEHOLDER\] ]]; then
                start_time=$(echo "$line" | grep -o '[0-9]*:[0-9]*[[:space:]]*[AP]M' | head -1 | sed 's/[[:space:]]//g')

                if [[ -n "$start_time" ]]; then
                    # Convert to 24-hour format
                    hour=$(echo "$start_time" | cut -d: -f1)
                    minute=$(echo "$start_time" | cut -d: -f2 | sed 's/[AP]M//')

                    if [[ "$start_time" =~ PM$ ]] && [[ "$hour" != "12" ]]; then
                        hour=$((hour + 12))
                    elif [[ "$start_time" =~ AM$ ]] && [[ "$hour" == "12" ]]; then
                        hour="00"
                    fi

                    # Format properly
                    if [[ ${#hour} -eq 1 ]]; then
                        hour="0$hour"
                    fi
                    if [[ ${#minute} -eq 1 ]]; then
                        minute="0$minute"
                    fi

                    start_time_24="${hour}:${minute}"
                    event_date=$(date +%Y-%m-%d)
                    event_datetime="${event_date} ${start_time_24}:00"
                    event_epoch=$(date -j -f "%Y-%m-%d %H:%M:%S" "$event_datetime" +%s 2>/dev/null)

                    # Only include future events
                    if [[ -n "$event_epoch" ]] && [[ $event_epoch -gt $current_time ]]; then
                        event_times+=("$start_time_24")
                        # Truncate long event names
                        truncated_name="${current_event:0:35}"
                        if [[ ${#current_event} -gt 35 ]]; then
                            truncated_name="${truncated_name}..."
                        fi
                        event_names+=("$truncated_name")
                    fi
                fi
            fi
        fi
    done <<< "$events"

    # Populate popup slots
    event_count=${#event_times[@]}

    if [[ $event_count -eq 0 ]]; then
        # No events - show message in first slot
        sketchybar --set calendar.event.1 \
                   label="No upcoming events today" \
                   drawing=on
        # Hide other slots
        for i in {2..5}; do
            sketchybar --set calendar.event.$i drawing=off
        done
    else
        # Show events (max 5)
        for i in {1..5}; do
            idx=$((i-1))
            if [[ $idx -lt $event_count ]]; then
                if [[ $i -eq 5 ]] && [[ $event_count -gt 5 ]]; then
                    # Last slot shows overflow count
                    remaining=$((event_count - 4))
                    sketchybar --set calendar.event.$i \
                               label="...and $remaining more events" \
                               drawing=on
                else
                    sketchybar --set calendar.event.$i \
                               label="[${event_times[$idx]}] ${event_names[$idx]}" \
                               drawing=on
                fi
            else
                sketchybar --set calendar.event.$i drawing=off
            fi
        done
    fi

    # Toggle popup
    sketchybar --set "${NAME:-calendar}" popup.drawing=toggle
fi
