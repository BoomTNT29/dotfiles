#!/bin/bash

# Get the device ID for the touchpad
device=$(xinput list --name-only | grep -i "touchpad")
device_id=$(xinput list | grep "$device" | grep -oP 'id=\K\d+')

# Get the property ID for "Enabling it and Disabling it"
prop_id=$(xinput list-props "$device_id" | grep -i "Device Enabled (" | grep -oP '\(\K\d+')
prop_val=$(xinput list-props "$device_id" | grep -i "Device Enabled" | grep -o [0-9]* | sed -n 2p)
echo $prop_val
prop_val=$((1 - prop_val))

# Enable tapping
xinput set-prop "$device_id" "$prop_id" "$prop_val"
echo "Device ID: $device_id, Property ID: $prop_id, Property Value: $prop_val"
