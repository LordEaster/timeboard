#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_settings() {
    load_env
    clear

    local env_file="$(dirname "$(dirname "$0")")/.env"
    mkdir -p "$(dirname "$env_file")"

    time_fmt="${TIME_FORMAT:-12}"
    temp_unit="${TEMP_UNIT:-C}"
    show_guide="${SHOW_GUIDE:-true}"
    location_mode="${LOCATION_MODE:-auto}"
    location_name="${LOCATION_NAME:-Bangkok}"

    block="
$(printf "\e[1;37m")
$(figlet "Settings") $(printf "\e[0m")

1. Time Format     : $time_fmt-hour ($([[ "$time_fmt" == "12" ]] && echo "11:59 PM" || echo "23:59"))   
2. Temp Unit       : $temp_unit ($([[ "$temp_unit" == "C" ]] && echo "Celsius" || echo "Fahrenheit"))   
3. Show Guide Bar  : $show_guide ($(echo "$show_guide" | sed 's/true/Visible/g; s/false/Hidden/g')) 
4. Location Mode     : $location_mode ($([[ "$location_mode" == "auto" ]] && echo "Use IP detection" || echo "Use fixed name"))
5. Fixed Location    : $location_name

"
    [[ "$SHOW_GUIDE" != "false" ]] && block+=$'\nPress → [i] Dashboard | [h] Help'
    show_centered_block "$block"

    read -rsn1 input
    case "$input" in
        1)
            new_fmt=$([[ "$time_fmt" == "12" ]] && echo "24" || echo "12")
            update_env "TIME_FORMAT" "$new_fmt"
            load_env
            show_settings
            ;;
        2)
            new_unit=$([[ "$temp_unit" == "C" ]] && echo "F" || echo "C")
            update_env "TEMP_UNIT" "$new_unit"
            load_env
            show_settings
            ;;
        3)
            new_guide=$([[ "$show_guide" == "true" ]] && echo "false" || echo "true")
            update_env "SHOW_GUIDE" "$new_guide"
            load_env
            show_settings
            ;;
        4)
            new_mode=$([[ "$location_mode" == "auto" ]] && echo "fixed" || echo "auto")
            update_env "LOCATION_MODE" "$new_mode"
            load_env
            show_settings
            ;;
        5)
            clear
            echo
            echo "Enter a fixed location (city, country, etc.):"
            read -rp "> " new_loc
            valid_loc=$(validate_location "$new_loc")

            if [[ -n "$valid_loc" ]]; then
                update_env "LOCATION_NAME" "$new_loc"
            else
                echo "⚠️ Invalid location. Please try again."
                sleep 2
            fi

            load_env
            show_settings
            ;;
        i) show_dashboard ;;
        h) show_help ;;
        *) show_settings ;;
    esac
}
