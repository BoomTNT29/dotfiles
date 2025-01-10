!/bin/bash

# Path to iwconfig and nmcli (install if not already installed)
IWCONFIG_PATH=$(command -v iwconfig)
NMCLI_PATH=$(command -v nmcli)

# Nerd Font WiFi icons
ICON_WIFI_0="󰤯 "
ICON_WIFI_1="󰤟 "
ICON_WIFI_2="󰤢 "
ICON_WIFI_3="󰤥 "
ICON_WIFI_4="󰤨 "
ICON_WIFI_OFF="󰤭 "
ICON_WIFI_NOT_CONNECTED="󰤮 "
ICON_WIFI_ALERT="󰤩 "

# Function to get WiFi signal strength
get_wifi_strength() {
    if [ -x "$IWCONFIG_PATH" ]; then
        signal_level=$(iwconfig 2>/dev/null | grep 'Link Quality' | awk '{print $2}' | cut -d '=' -f 2 | cut -d '/' -f 1)
        if [ -z "$signal_level" ]; then
            signal_level=0
        fi
    else
        signal_level=0
    fi
}

# Function to check WiFi connection status
get_wifi_status() {
    if [ -x "$NMCLI_PATH" ]; then
        wifi_status=$(nmcli -t -f WIFI g)
        connection_status=$(nmcli -t -f STATE device status | grep 'connected' | grep -v 'disconnected')
    else
        wifi_status="disabled"
        connection_status=""
    fi
}

# Function to get the appropriate WiFi icon
get_wifi_icon() {
    if [[ $wifi_status == "disabled" ]]; then
        echo -n "$ICON_WIFI_OFF"
    elif [[ -z $connection_status ]]; then
        echo -n "$ICON_WIFI_NOT_CONNECTED"
    else
        if (( signal_level >= 70 )); then
            echo -n "$ICON_WIFI_4"
        elif (( signal_level >= 55 )); then
            echo -n "$ICON_WIFI_3"
        elif (( signal_level >= 40 )); then
            echo -n "$ICON_WIFI_2"
        elif (( signal_level >= 25 )); then
            echo -n "$ICON_WIFI_1"
        else
            echo -n "$ICON_WIFI_0"
        fi
    fi
}

# Main function to display WiFi status with icon
main() {
    get_wifi_strength
    get_wifi_status
    icon=$(get_wifi_icon)
    echo "$icon"
}

main
