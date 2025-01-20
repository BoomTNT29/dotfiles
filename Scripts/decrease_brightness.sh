#!/bin/bash
brightnessctl set 10%-
curr_brightness=$(brightnessctl g)
curr_brightness=$((curr_brightness * 100 / 255))
notify-send -u "low" -t 500 -r 1001 "Brightness" "Brightness set at $curr_brightness%"
