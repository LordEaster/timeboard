show_clock() {
    load_env
    while true; do
        clear

        # Time format
        [[ "$TIME_FORMAT" == "24" ]] && fmt="%H : %M : %S" || fmt="%I : %M : %S %p"
        now=$(date +"$fmt")
        date=$(date "+%A %d %B %Y")

        block="
$(figlet "Clock")

$(figlet "$now")
$date
"

        [[ "$SHOW_GUIDE" != "false" ]] && block+=$'\nPress → [i] Dashboard | [w] Weather | [e] Events | [s] Settings | [h] Help'
        show_centered_block "$block"

        read -rsn1 -t 1 input
        handle_shortcut "$input" && return
    done
}
