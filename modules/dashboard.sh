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

        # Weather format
        if [[ "$TEMP_UNIT" == "F" ]]; then
            weather=$(curl -s "wttr.in/?format=3&u")
        else
            weather=$(curl -s "wttr.in/?format=3")
        fi

        block="
- Random Quote and Reminder (Coming Soon) -

$(figlet "$now")
$(figlet "$date")

$weather
"

        [[ "$SHOW_GUIDE" != "false" ]] && block+=$'\nPress → [c] Clock | [w] Weather | [e] Events | [s] Settings | [h] Help'

        show_centered_block "$block"

        read -t 15 -rsn1 input
        handle_shortcut "$input" && return
    done
}
