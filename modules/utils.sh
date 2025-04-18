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

load_env() {
    local env_file="$(dirname "$(dirname "$0")")/.env"
    [[ -f "$env_file" ]] && export $(grep -v '^#' "$env_file" | xargs)
}

update_env() {
    local key="$1"
    local value="$2"
    local env_file="$(dirname "$(dirname "$0")")/.env"

    touch "$env_file"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS requires '' after -i
        if grep -q "^$key=" "$env_file"; then
            sed -i '' "s|^$key=.*|$key=$value|" "$env_file"
        else
            echo "$key=$value" >> "$env_file"
        fi
        sed -i '' '/^\s*$/d' "$env_file"
    else
        # Linux
        if grep -q "^$key=" "$env_file"; then
            sed -i "s|^$key=.*|$key=$value|" "$env_file"
        else
            echo "$key=$value" >> "$env_file"
        fi
        sed -i '/^\s*$/d' "$env_file"
    fi
}

handle_shortcut() {
    case "$1" in
        i) show_dashboard ;;
        c) show_clock ;;
        w) show_weather ;;
        e) show_events ;;
        s) show_settings ;;
        h) show_help ;;
        *) return 1 ;;
    esac
}

validate_location() {
    local query="$1"
    local result
    result=$(curl -s "wttr.in/${query// /%20}?format=%l" | head -n 1)

    # Accept if not empty and not "Unknown location"
    if [[ -n "$result" && "$result" != *"Unknown location"* ]]; then
        echo "$result"
    else
        echo ""
    fi
}
