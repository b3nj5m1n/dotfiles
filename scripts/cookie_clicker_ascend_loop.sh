#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash ydotool

export YDOTOOL_SOCKET="/tmp/.ydotool_socket"

buy_all_upgrades() {
    # Move to buy all button
    ydotool mousemove --absolute -x 865 -y 73
    ydotool click 0xC0
    reset_upgrade_menu
}
ascend() {
    # Move to legacy button
    ydotool mousemove --absolute -x 770 -y 40
    ydotool click 0xC0
    # Move to ascend button
    ydotool mousemove --absolute -x 480 -y 305
    ydotool click 0xC0
    sleep 7
    # Move to reincarnate button
    ydotool mousemove --absolute -x 480 -y 50
    ydotool click 0xC0
    # Move to yes button
    ydotool mousemove --absolute -x 470 -y 280
    ydotool click 0xC0
}
buy_cursors() {
    # Move to cursors
    ydotool mousemove --absolute -x 865 -y 150
    ydotool click --repeat 1 --next-delay 200 0xC0
}
buy_condensors() {
    ydotool mousemove --absolute -x 905 -y 530
    ydotool click --repeat 1 --next-delay 200 0xC0
}
buy_100() {
    ydotool mousemove --absolute -x 905 -y 125
    ydotool click 0xC0
}
reset_upgrade_menu() {
    sleep 0.1
    ydotool mousemove --absolute -x 480 -y 305
    sleep 0.2
}

loop() {
    while true
    do
        buy_all_upgrades
        buy_100
        buy_cursors
        sleep 2
        buy_all_upgrades
        buy_100
        buy_cursors
        buy_condensors
        buy_all_upgrades
        sleep 2
        buy_all_upgrades
        buy_100
        buy_cursors
        buy_condensors
        buy_all_upgrades
        sleep 2
        buy_all_upgrades
        buy_100
        buy_cursors
        buy_condensors
        buy_all_upgrades
        sleep 2
        buy_all_upgrades
        buy_100
        buy_cursors
        buy_condensors
        buy_all_upgrades
        sleep 2
        buy_all_upgrades
        buy_100
        buy_cursors
        buy_condensors
        buy_all_upgrades
        sleep 2
        # buy_all_upgrades
        # sleep 5
        ascend
        sleep 1
    done
}
loop
