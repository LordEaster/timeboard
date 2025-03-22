#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_weather() {
    clear
    echo
    echo
    echo
    echo
    show_centered "$(figlet "Weather")"

    weather_data=$(curl -s "wttr.in/?format=j1")

    if [[ -z "$weather_data" ]]; then
        show_centered "⚠️ Unable to fetch weather data."
    else
        location=$(echo "$weather_data" | jq -r '.nearest_area[0].areaName[0].value')
        temp=$(echo "$weather_data" | jq -r '.current_condition[0].temp_C')
        feels_like=$(echo "$weather_data" | jq -r '.current_condition[0].FeelsLikeC')
        wind_speed=$(echo "$weather_data" | jq -r '.current_condition[0].windspeedKmph')
        wind_dir=$(echo "$weather_data" | jq -r '.current_condition[0].winddir16Point')
        humidity=$(echo "$weather_data" | jq -r '.current_condition[0].humidity')
        condition=$(echo "$weather_data" | jq -r '.current_condition[0].weatherDesc[0].value')

        show_centered "$location"
        echo
        show_centered "$(figlet "$temp C")"
        show_centered "$(figlet "$condition")"
        echo
        show_centered "feels like $feels_like C"
        show_centered "Wind: $wind_speed km/h ($wind_dir)"
        show_centered "Humidity: $humidity%"
    fi

    read -rsn1 input
    case "$input" in
        i) show_dashboard ;;
        c) show_clock ;;
        e) show_events ;;
        w) show_weather ;;
        h) show_help ;;
    esac
}
