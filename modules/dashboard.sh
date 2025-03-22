#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_dashboard() {
    while true; do
        clear
        now=$(date "+%I : %M  %p")
        date=$(date "+%d %B %Y")
        weather=$(curl -s "wttr.in/?format=3")

        block="
- Random Quote and Reminder (Coming Soon) -

$(figlet "$now")
$(figlet "$date")

$weather

TimeBoard | h for help
"
        show_centered_block "$block"

        read -t 15 -rsn1 input
        case "$input" in
            i) show_dashboard ;;
            c) show_clock ;;
            e) show_events ;;
            w) show_weather ;;
            h) show_help ;;
        esac
    done
}
