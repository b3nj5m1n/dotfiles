#!/bin/bash

# Just a simple Lemonbar script
# Only clickable workspaces, window title, and clock
# Spamming command every second using shell to generate statusline is not really efficient
# So I only put those three items
# If I need other status informations
# I'd rather to call them using Dunst

# Workspace indicator is generated using bspc subscribe
# Which only update if there is an reaction on bspwm
# Window title is generated using xtitle
# Which also has subscribe event ability
# Clock is generated using looped date command
# Only update every thirty seconds

# Based on default example from Bspwm GitHub repository
# Some parts are modified to make them look like what i want
# Cheers! Addy

FOREGROUND="#f5f5f5"
BACKGROUND="#171517"
BLACK="#0a090a"
RED="#ff1b1c"
GREEN="#ff0066"
YELLOW="#f0e100"
BLUE="#00b4d8"
MAGENTA="#700353"
CYAN="#00ff99"
WHITE="#f8f8f8"

# Panel configurations
PANEL_HEIGHT=24
PANEL_WIDTH=1920
PANEL_HORIZONTAL_OFFSET=0
PANEL_VERTICAL_OFFSET=0
PANEL_FONT="UbuntuMono Nerd Font 12"
PANEL_FIFO=/tmp/panel-fifo
PANEL_WM_NAME=bspwm_panel
COLOR_DEFAULT_FG="$FOREGROUND"
COLOR_DEFAULT_BG="$BACKGROUND"
COLOR_MONITOR_FG="$FOREGROUND"
COLOR_MONITOR_BG="$BACKGROUND"
COLOR_FOCUSED_MONITOR_FG="$FOREGROUND"
COLOR_FOCUSED_MONITOR_BG="$CYAN"
COLOR_FREE_FG="$BLACK"
COLOR_FREE_BG="$BACKGROUND"
COLOR_FOCUSED_FREE_FG="$FOREGROUND"
COLOR_FOCUSED_FREE_BG="$BLUE"
COLOR_OCCUPIED_FG="$FOREGROUND"
COLOR_OCCUPIED_BG="$BACKGROUND"
COLOR_FOCUSED_OCCUPIED_FG="$FOREGROUND"
COLOR_FOCUSED_OCCUPIED_BG="$BLUE"
COLOR_URGENT_FG="$FOREGROUND"
COLOR_URGENT_BG="$YELLOW"
COLOR_FOCUSED_URGENT_FG="$FOREGROUND"
COLOR_FOCUSED_URGENT_BG="$YELLOW"
COLOR_STATE_FG="$BACKGROUND"
COLOR_STATE_BG="$BACKGROUND"
COLOR_TITLE_FG="$FOREGROUND"
COLOR_TITLE_BG="$BACKGROUND"
COLOR_SYS_FG="$FOREGROUND"
COLOR_SYS_BG="$GREEN"

[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
mkfifo "$PANEL_FIFO"

clock() {
    while true; do
        date +"S%a %-d %b %H:%M"
        sleep 30
    done
}

# Just to make sure there is no double process
killall -9 lemonbar xtitle xdo clock

# Echo every modules to PANEL_FIFO
clock > "$PANEL_FIFO" &
xtitle -t 70 -sf 'T%s\n' > "$PANEL_FIFO" &
bspc subscribe report > "$PANEL_FIFO" &
num_mon=$(bspc query -M | wc -l)

# Then read those value
panel_bar() {
    while read -r line ; do
        case $line in
            S*)
                # clock output
                sys="%{F$COLOR_SYS_FG}%{B$COLOR_SYS_BG} ${line#?} %{B-}%{F-}"
                ;;
            T*)
                # xtitle output
                title="%{F$COLOR_TITLE_FG}%{B$COLOR_TITLE_BG} ${line#?} %{B-}%{F-}"
                ;;
            W*)
                # workspaces output
                wm=
                IFS=':'
                set -- ${line#?}
                while [ $# -gt 0 ] ; do
                    item=$1
                    name=${item#?}
                    case $item in
                        [mM]*)
                            case $item in
                                m*)
                                    # monitor
                                    FG=$COLOR_MONITOR_FG
                                    BG=$COLOR_MONITOR_BG
                                    on_focused_monitor=
                                    ;;
                                M*)
                                    # focused monitor
                                    FG=$COLOR_FOCUSED_MONITOR_FG
                                    BG=$COLOR_FOCUSED_MONITOR_BG
                                    on_focused_monitor=1
                                    ;;
                            esac
                            [ $num_mon -lt 2 ] && shift && continue
                            wm="${wm}%{F${FG}}%{B${BG}}%{A:bspc monitor -f ${name}:} ${name} %{A}%{B-}%{F-}"
                            ;;
                        [fFoOuU]*)
                            case $item in
                                f*)
                                    # free desktop
                                    FG=$COLOR_FREE_FG
                                    BG=$COLOR_FREE_BG
                                    UL=$BG
                                    ;;
                                F*)
                                    if [ "$on_focused_monitor" ] ; then
                                        # focused free desktop
                                        FG=$COLOR_FOCUSED_FREE_FG
                                        BG=$COLOR_FOCUSED_FREE_BG
                                        UL=$BG
                                    else
                                        # active free desktop
                                        FG=$COLOR_FREE_FG
                                        BG=$COLOR_FREE_BG
                                        UL=$COLOR_FOCUSED_FREE_BG
                                    fi
                                    ;;
                                o*)
                                    # occupied desktop
                                    FG=$COLOR_OCCUPIED_FG
                                    BG=$COLOR_OCCUPIED_BG
                                    UL=$BG
                                    ;;
                                O*)
                                    if [ "$on_focused_monitor" ] ; then
                                        # focused occupied desktop
                                        FG=$COLOR_FOCUSED_OCCUPIED_FG
                                        BG=$COLOR_FOCUSED_OCCUPIED_BG
                                        UL=$BG
                                    else
                                        # active occupied desktop
                                        FG=$COLOR_OCCUPIED_FG
                                        BG=$COLOR_OCCUPIED_BG
                                        UL=$COLOR_FOCUSED_OCCUPIED_BG
                                    fi
                                    ;;
                                u*)
                                    # urgent desktop
                                    FG=$COLOR_URGENT_FG
                                    BG=$COLOR_URGENT_BG
                                    UL=$BG
                                    ;;
                                U*)
                                    if [ "$on_focused_monitor" ] ; then
                                        # focused urgent desktop
                                        FG=$COLOR_FOCUSED_URGENT_FG
                                        BG=$COLOR_FOCUSED_URGENT_BG
                                        UL=$BG
                                    else
                                        # active urgent desktop
                                        FG=$COLOR_URGENT_FG
                                        BG=$COLOR_URGENT_BG
                                        UL=$COLOR_FOCUSED_URGENT_BG
                                    fi
                                    ;;
                            esac
                            wm="${wm}%{F${FG}}%{B${BG}}%{U${UL}}%{+u}%{A:bspc desktop -f ${name}:} ${name} %{A}%{B-}%{F-}%{-u}"
                            ;;
                        [LTG]*)
                            # layout, state and flags
                            wm="${wm}%{F$COLOR_STATE_FG}%{B$COLOR_STATE_BG} ${name} %{B-}%{F-}"
                            ;;
                    esac
                    shift
                done
                ;;
        esac
        printf "%s\n" "%{l}${wm}%{c}${title}%{r}${sys}"
    done
}

# Get all the results of the modules above then pipe them to Lemonbar
panel_bar < "$PANEL_FIFO" | lemonbar -a 12 \
    -g "$PANEL_WIDTH"x"$PANEL_HEIGHT"+"$PANEL_HORIZONTAL_OFFSET"+"$PANEL_VERTICAL_OFFSET" \
    -f "$PANEL_FONT" -F "$COLOR_DEFAULT_FG" -B "$COLOR_DEFAULT_BG" -n "$PANEL_WM_NAME" | bash &

sleep 0.5
# Trigger the PANEL_FIFO to make it instantly refreshed after bspwmrc reloaded 
echo "dummy" > "$PANEL_FIFO"

sleep 0.5
# Rule the panel to make it hiding below fullscreen window
# I add 'sleep 0.5' to avoid xdo executed before the Lemonbar fully loaded
wid=$(xdo id -a "$PANEL_WM_NAME")
xdo above -t "$(xdo id -N Bspwm -n root | sort | head -n 1)" "$wid"

# Don't close this process
wait

