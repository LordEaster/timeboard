#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_clock() {
    while true; do
        clear
        now=$(date "+%I : %M : %S %p")
        date=$(date "+%A %d %B %Y")

        block="
$(figlet "Clock")

$(figlet "$now")
$date
"
        show_centered_block "$block"

        read -rsn1 -t 1 input
        case "$input" in
            i) show_dashboard ;;
            c) show_clock ;; # optional to refresh manually
            e) show_events ;;
            w) show_weather ;;
            h) show_help ;;
        esac
    done
}
