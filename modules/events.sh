#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_events() {
    clear

    local ROOT_DIR="$(dirname "$(dirname "$0")")"
    local DATA_FILE="$ROOT_DIR/data/events.json"

    block="$(figlet "Events")"$'\n\n'

    if [[ -f "$DATA_FILE" && -s "$DATA_FILE" ]]; then
        while IFS=$'\t' read -r date title; do
            max_len=25

            if [[ ${#title} -gt $max_len ]]; then
                title="${title:0:$((max_len-3))}..."
            else
                title=$(printf "%-${max_len}s" "$title")
            fi

            block+="$date  -  $title"$'\n'
        done < <(jq -r '.[] | [.date, .title] | @tsv' "$DATA_FILE")
    else
        block+="No upcoming events"$'\n'
    fi

    show_centered_block "$block"

    read -rsn1 input
    case "$input" in
        c) show_clock ;;
        w) show_weather ;;
        i) show_dashboard ;;
        h) show_help ;;
    esac
}
