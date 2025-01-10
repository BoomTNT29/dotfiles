#!/bin/bash

# Get the current volume level
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -1)

# Check if the current volume is less than 100%
if [ "$current_volume" -lt 100 ]; then
    # Increase the volume by 5%
    pactl set-sink-volume @DEFAULT_SINK@ +5%
else
    echo "Volume is already at or above 100%."
fi
