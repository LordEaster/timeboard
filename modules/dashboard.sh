#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_dashboard() {
    load_env

    while true; do
        clear

        # Time format
        if [[ "$TIME_FORMAT" == "24" ]]; then
            time_fmt="%H : %M"
        else
            time_fmt="%I : %M %p"
        fi

        now=$(date +"$time_fmt")
        date=$(date "+%d %B %Y")

        # Determine location
        if [[ "$LOCATION_MODE" == "auto" ]]; then
            location=$(curl -s ipinfo.io/city)
        else
            location="$LOCATION_NAME"
        fi

        # Weather format
        if [[ "$TEMP_UNIT" == "F" ]]; then
            weather_data=$(curl -s "wttr.in/${location// /%20}?format=j1&u")
        else
            weather_data=$(curl -s "wttr.in/${location// /%20}?format=j1")
        fi

        if [[ -n "$weather_data" && "$weather_data" != "null" ]]; then
            location_name=$(echo "$weather_data" | jq -r '.nearest_area[0].areaName[0].value')
            weather_line=$(echo "$weather_data" | jq -r '.current_condition[0].weatherDesc[0].value')
            temp=$(echo "$weather_data" | jq -r ".current_condition[0].temp_${TEMP_UNIT:-C}")
            weather="📍 $location_name  |  $weather_line, $temp °$TEMP_UNIT"
        else
            weather="⚠️ Unable to fetch weather info"
        fi

        block="
- Random Quote and Reminder (Coming Soon) -

$(printf "\e[1;37m")
$(figlet -f big "$now") $(printf "\e[0m")
$(figlet "$date")

$weather
"

        [[ "$SHOW_GUIDE" != "false" ]] && block+=$'\nPress → [c] Clock | [w] Weather | [e] Events | [s] Settings | [h] Help'

        show_centered_block "$block"

        read -t 15 -rsn1 input
        handle_shortcut "$input" && return
    done
}