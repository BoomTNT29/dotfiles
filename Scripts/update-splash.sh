#!/bin/bash

# Path to the splashes file
SPLASHES_FILE=/home/krishna/Documents/splashes.txt

# Get a random splash text
SPLASH_TEXT=$(shuf -n 1 "$SPLASHES_FILE")

# Path to the ly config file
LY_CONFIG_FILE=/etc/ly/config.ini

# Update the ly config file with the random splash text
sed -i "s/^box_title = .*/box_title = $SPLASH_TEXT/" "$LY_CONFIG_FILE"
