#!/bin/bash
source "$(dirname "$0")/utils.sh"

show_help() {
    clear
    echo
    echo
    show_centered "$(figlet "TimeBoard")"
    show_centered "Version: 0.1.0"
    show_centered "--------------------------------------"
    show_centered "A simple dashboard for your terminal"
    show_centered "by @LordEaster (GitHub) | BSO Space"
    show_centered "--------------------------------------"
    echo
    show_centered "Press the following keys to navigate:"
    echo
    show_centered "i - Dashboard"
    show_centered "c - Clock"
    show_centered "w - Weather"
    show_centered "e - Events"
    echo
    show_centered "Press any key to return to dashboard"
    read -rsn1 input
    show_dashboard
}
