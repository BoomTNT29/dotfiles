#!/bin/bash

# Get the device ID for the touchpad
device=$(xinput list --name-only | grep -i "touchpad")
device_id=$(xinput list | grep "$device" | grep -oP 'id=\K\d+')

# Get the property ID for "Tapping Enabled"
prop_id=$(xinput list-props "$device_id" | grep -i "Tapping Enabled (" | grep -oP '\(\K\d+')

# Enable tapping
xinput set-prop "$device_id" "$prop_id" 1
