#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_dashboard() {
    while true; do
        clear
        echo
        echo
        echo
        echo
        now=$(date "+%I : %M  %p")
        date=$(date "+%d %B %Y")
        weather=$(curl -s "wttr.in/?format=3")
        show_centered "- Random Quote and Reminder (Coming Soon) -"
        echo
        show_centered "$(figlet "$now")"
        show_centered "$(figlet $date)"
        echo
        show_centered "$weather"
        echo
        echo
        show_centered "TimeBoard | h for help"

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
