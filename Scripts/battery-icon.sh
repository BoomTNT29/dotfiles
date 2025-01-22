#!/bin/bash

LOW_BATTERY=25

# Path to acpi (install acpi if not already installed)
ACPI_PATH=$(command -v acpi)

# Nerd Font battery icons
ICON_FULL="󰁹 "
ICON_FULL_CHARG="󰂅 "
ICON_DISCHARGING=""
ICON_UNKNOWN="󰂑 "
ICON_CRITICAL="󱟩 "
ICON_TEN="󰁺 "
ICON_TWEN="󰁻 "
ICON_THIRT="󰁼 "
ICON_FOUR="󰁽 "
ICON_FIF="󰁾 "
ICON_SIX="󰁿 "
ICON_SEVEN="󰂀 "
ICON_EIGH="󰂁 "
ICON_NINE="󰂂 "
ICON_TEN_CHARG="󰢜 "
ICON_TWEN_CHARG="󰂆 "
ICON_THIRT_CHARG="󰂇 "
ICON_FOUR_CHARG="󰂈 "
ICON_FIF_CHARG="󰢝 "
ICON_SIX_CHARG="󰂉 "
ICON_SEVEN_CHARG="󰢞 "
ICON_EIGH_CHARG="󰂊 "
ICON_NINE_CHARG="󰂋 "
ICON_EMPTY="󰂎 "

# Function to get battery percentage and status
get_battery_status() {
    if [ -x "$ACPI_PATH" ]; then
        battery_info=$($ACPI_PATH -b)
        battery_percentage=$(echo "$battery_info" | grep -P -o '[0-9]+(?=%)')
        battery_state=$(echo "$battery_info" | grep -oP 'Charging|Discharging|Full|Unknown')
    else
        battery_percentage=0
        battery_state="Unknown"
    fi
}

# Function to get the appropriate icon
get_battery_icon() {
    if [[ $battery_state == "Full" ]]; then
        echo -n "$ICON_FULL"
    elif [[ $battery_state == "Charging" ]]; then
        if (( battery_percentage >= 95 )); then
            echo -n "$ICON_FULL_CHARG"
        elif (( battery_percentage >= 90 )); then
            echo -n "$ICON_NINE_CHARG"
        elif (( battery_percentage >= 80 )); then
            echo -n "$ICON_EIGH_CHARG"
        elif (( battery_percentage >= 70 )); then
            echo -n "$ICON_SEVEN_CHARG"
        elif (( battery_percentage >= 60 )); then
            echo -n "$ICON_SIX_CHARG"
        elif (( battery_percentage >= 50 )); then
            echo -n "$ICON_FIF_CHARG"
        elif (( battery_percentage >= 40 )); then
            echo -n "$ICON_FOUR_CHARG"
        elif (( battery_percentage >= 30 )); then
            echo -n "$ICON_THIRT_CHARG"
        elif (( battery_percentage >= 20 )); then
            echo -n "$ICON_TWEN_CHARG"
        elif (( battery_percentage >= 10 )); then
	    echo -n "$ICON_TEN_CHARG"
        else
            echo -n "$ICON_EMPTY"
        fi
    elif [[ $battery_state == "Discharging" ]]; then
        if (( battery_percentage >= 95 )); then
            echo -n "$ICON_FULL"
        elif (( battery_percentage >= 90 )); then
            echo -n "$ICON_NINE"
        elif (( battery_percentage >= 80 )); then
            echo -n "$ICON_EIGH"
        elif (( battery_percentage >= 70 )); then
            echo -n "$ICON_SEVEN"
        elif (( battery_percentage >= 60 )); then
            echo -n "$ICON_SIX"
        elif (( battery_percentage >= 50 )); then
            echo -n "$ICON_FIF"
        elif (( battery_percentage >= 40 )); then
            echo -n "$ICON_FOUR"
        elif (( battery_percentage >= 30 )); then
            echo -n "$ICON_THIRT"
        elif (( battery_percentage >= 20 )); then
            echo -n "$ICON_TWEN"
				elif (( battery_percentage >= 10 )); then
					echo -n "$ICON_TEN"
        else
          echo -n "$ICON_EMPTY"
        fi

				if (( battery_percentage <= LOW_BATTERY )); then
					notify-send -u "critical" -t 0 -r 1003 -i "/home/krishna/.local/share/icons/dunst/battery-alert.png" "Low Baattery" "Please charge your laptop"
				fi
    else
        echo -n "$ICON_UNKNOWN"
    fi
}

# Main function to display battery status with icon
main() {
    get_battery_status
    icon=$(get_battery_icon)
    echo "$icon$battery_percentage%"
}

main
