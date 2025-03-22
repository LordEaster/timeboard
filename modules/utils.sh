#!/bin/bash
show_centered() {
    while IFS= read -r line; do
        printf "%*s\n" $(( ( $(tput cols) + ${#line} ) / 2 )) "$line"
    done <<< "$1"
}

show_centered_block() {
    local lines=()
    local line
    local term_height=$(tput lines)
    local padding

    while IFS= read -r line; do
        lines+=("$line")
    done <<< "$1"

    local content_height=${#lines[@]}
    padding=$(( (term_height - content_height) / 2 ))

    for ((i = 0; i < padding; i++)); do
        echo ""
    done

    for line in "${lines[@]}"; do
        printf "%*s\n" $(( ( $(tput cols) + ${#line} ) / 2 )) "$line"
    done
}