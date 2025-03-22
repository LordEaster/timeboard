#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_weather() {
    load_env
    clear

    block="
$(figlet "Weather")
"

    # Decide unit based on user preference
    if [[ "$TEMP_UNIT" == "F" ]]; then
        weather_data=$(curl -s "wttr.in/?format=j1&u")
        temp_key="temp_F"
        feels_key="FeelsLikeF"
        unit="F"
    else
        weather_data=$(curl -s "wttr.in/?format=j1")
        temp_key="temp_C"
        feels_key="FeelsLikeC"
        unit="C"
    fi

    if [[ -z "$weather_data" || "$weather_data" == "null" ]]; then
        block+="\n⚠️ Unable to fetch weather data.\n"
    else
        location=$(echo "$weather_data" | jq -r '.nearest_area[0].areaName[0].value')
        temp=$(echo "$weather_data" | jq -r ".current_condition[0].$temp_key")
        feels_like=$(echo "$weather_data" | jq -r ".current_condition[0].$feels_key")
        wind_speed=$(echo "$weather_data" | jq -r '.current_condition[0].windspeedKmph')
        wind_dir=$(echo "$weather_data" | jq -r '.current_condition[0].winddir16Point')
        humidity=$(echo "$weather_data" | jq -r '.current_condition[0].humidity')
        condition=$(echo "$weather_data" | jq -r '.current_condition[0].weatherDesc[0].value')

        block+="$location

$(figlet "$temp $unit")
feels like $feels_like $unit

$(figlet "$condition")

Wind: $wind_speed km/h ($wind_dir)
Humidity: $humidity%
"
    fi

    [[ "$SHOW_GUIDE" != "false" ]] && block+=$'\nPress → [i] Dashboard | [c] Clock | [e] Events | [s] Settings | [h] Help'

    show_centered_block "$block"

    read -rsn1 input
    handle_shortcut "$input" && return
}
