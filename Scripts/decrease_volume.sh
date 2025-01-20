#!/bin/bash
/usr/bin/pactl set-sink-volume @DEFAULT_SINK@ -5%
vol=$(pactl get-sink-volume $(pactl get-default-sink) | grep -oP '\d+%+' | head -1)
notify-send -u "low" -t 500 -r 1000 "Volume" "Volume set at $vol"
