#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_weather() {
    clear

    weather_data=$(curl -s "wttr.in/?format=j1")

    block="
$(figlet "Weather")
"

    if [[ -z "$weather_data" || "$weather_data" == "null" ]]; then
        block+="\n⚠️ Unable to fetch weather data.\n"
    else
        location=$(echo "$weather_data" | jq -r '.nearest_area[0].areaName[0].value')
        temp=$(echo "$weather_data" | jq -r '.current_condition[0].temp_C')
        feels_like=$(echo "$weather_data" | jq -r '.current_condition[0].FeelsLikeC')
        wind_speed=$(echo "$weather_data" | jq -r '.current_condition[0].windspeedKmph')
        wind_dir=$(echo "$weather_data" | jq -r '.current_condition[0].winddir16Point')
        humidity=$(echo "$weather_data" | jq -r '.current_condition[0].humidity')
        condition=$(echo "$weather_data" | jq -r '.current_condition[0].weatherDesc[0].value')

        block+="$location
$(figlet "$temp C")

feels like $feels_like C

$(figlet "$condition")

Wind: $wind_speed km/h ($wind_dir)
Humidity: $humidity%
"
    fi

    show_centered_block "$block"

    read -rsn1 input
    case "$input" in
        i) show_dashboard ;;
        c) show_clock ;;
        e) show_events ;;
        w) show_weather ;;
        h) show_help ;;
    esac
}
