#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_help() {
    clear

    block="
$(figlet "TimeBoard")
Version: 0.1.1
--------------------------------------
A simple dashboard for your terminal
by @LordEaster (GitHub) | BSO Space
--------------------------------------

Press the following keys to navigate:

i - Dashboard
c - Clock
w - Weather
e - Events

Press any key to return to dashboard
"

    show_centered_block "$block"

    read -rsn1 input
    show_dashboard
}
