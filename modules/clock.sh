#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_clock() {
    while true; do
        clear
        now=$(date "+%I : %M : %S %p")
        date=$(date "+%A %d %B %Y")
        echo
        echo
        echo
        echo
        show_centered "$(figlet "Clock")"
        echo
        show_centered "$(figlet "$now")"
        show_centered "$date"
        read -rsn1 -t 1 input
        case "$input" in
            i) show_dashboard ;;
            c) show_clock ;;
            e) show_events ;;
            w) show_weather ;;
            h) show_help ;;
        esac
    done
}
