#!/bin/bash

# ====== Detect OS and Set Installer ======
IS_MAC=false
INSTALL_CMD=""

if [[ "$OSTYPE" == "darwin"* ]]; then
    IS_MAC=true
    if ! command -v brew >/dev/null 2>&1; then
        echo "❌ Homebrew not found. Please install it from https://brew.sh/"
        exit 1
    fi
    INSTALL_CMD="brew install"
else
    INSTALL_CMD="sudo apt update && sudo apt install -y"
fi

# ====== Dependency Check & Install ======
REQUIRED_PKGS=("figlet" "curl" "jq")

echo "🔍 Checking for required packages..."
for pkg in "${REQUIRED_PKGS[@]}"; do
    if ! command -v $pkg >/dev/null 2>&1; then
        echo "📦 Installing missing package: $pkg"
        $INSTALL_CMD $pkg
    fi
done

# ====== Utility: Centered Text ======
show_centered() {
    while IFS= read -r line; do
        printf "%*s\n" $(( ( $(tput cols) + ${#line} ) / 2 )) "$line"
    done <<< "$1"
}

# ====== Module: Clock (Real-time) ======
show_clock() {
    while true; do
        clear
        now=$(date "+%H : %M : %S")
        date=$(date "+%A %Y-%m-%d")
        show_centered "$(figlet "Clock")"
        echo
        show_centered "$(figlet "$now")"
        show_centered "$date"
        echo
        echo
        show_centered "Press h to return to dashboard"
        
        # Wait for 1 second, check if the user pressed 'h' to exit
        read -rsn1 -t 1 input
        [[ $input == "h" ]] && break
    done
}

# ====== Module: Weather (More details) ======
show_weather() {
    clear
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

    echo
    show_centered "Press h to return to dashboard"
    read -rsn1 input
}

# ====== Module: Events ======
show_events() {
    clear
    show_centered "$(figlet "Events")"
    echo
    if [ -f ./events.json ]; then
        jq -r '.[] | "\(.date) \(.title)"' events.json | while read -r line; do
            show_centered "$line"
        done
    else
        show_centered "No upcoming events"
    fi
    echo
    show_centered "Press h to return to dashboard"
    read -rsn1 input
}

# ====== Dashboard ======
show_dashboard() {
    while true; do
        clear
        now=$(date "+%H : %M")
        date=$(date "+%A %Y-%m-%d")
        weather=$(curl -s "wttr.in/?format=3")

        show_centered "$(figlet "TimeBoard")"
        echo
        show_centered "$(figlet "$now")"
        show_centered "$date"
        echo
        show_centered "$weather"
        echo
        echo
        show_centered "Press 1: Clock | 2: Weather | 3: Events"

        read -t 15 -rsn1 input
        case "$input" in
            1) show_clock ;;
            2) show_weather ;;
            3) show_events ;;
        esac
    done
}


# ====== Launch TimeBoard ======
show_dashboard
