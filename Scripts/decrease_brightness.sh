#!/bin/bash
brightnessctl set 10%-
curr_brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
curr_brightness=$((curr_brightness * 100 / max_brightness))
notify-send -u "low" -t 500 -r 1001 "Brightness" "Brightness set at $curr_brightness%"
