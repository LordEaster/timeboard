#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_help() {
    load_env
    clear

    local ROOT_DIR="$(dirname "$(dirname "$0")")"
    local VERSION_FILE="$ROOT_DIR/VERSION"
    local VERSION="Unknown"

    [[ -f "$VERSION_FILE" ]] && VERSION=$(cat "$VERSION_FILE")

    block="
$(printf "\e[1;37m") 
$(figlet "TimeBoard") $(printf "\e[0m")
Version: $VERSION
--------------------------------------
A simple dashboard for your terminal
by @LordEaster (GitHub) | BSO Space
--------------------------------------

Press the following keys to navigate:

i - Dashboard
c - Clock
w - Weather
e - Events
s - Settings
h - Help

Crlt + c - Exit

Press any key to return to dashboard
"
    show_centered_block "$block"

    read -rsn1 input
    handle_shortcut "$input" || show_dashboard
}
