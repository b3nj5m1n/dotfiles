#!/usr/bin/env sh
# echo "#[fg=#02B696]#[bg=#D5D5B0]#[bold]%d/%m %H:%M"

##### Style Variables #####
export default_fg="#f8f8f2"
export default_bg="#282a36"
export default_prefix=" "
export default_suffix=" "
export date_fg="#f8f8f2"
export date_bg="#bd93f9"
export hostname_fg="#f8f8f2"
export hostname_bg="#50fa7b"
export uptime_fg="#f8f8f2"
export uptime_bg="#ffb86c"
export currentwindow_fg="#f8f8f2"
export currentwindow_bg="#bd93f9"

##### Style Control #####
style_text() {
    printf "#[%s]" "$1"
}
style_fg() {
    printf "#[fg=#%s]" "$1"
}
style_bg() {
    printf "#[bg=#%s]" "$1"
}
prefix() {
    printf "%s" "$default_prefix"
}
suffix() {
    printf "%s" "$default_suffix"
}

component_date() {
    style_fg "$date_fg"
    style_bg "$date_bg"
    prefix
    printf "%s" "$(date -u +"%d/%m/%Y")"
    suffix
}
component_hostname() {
    style_text bold
    style_fg "$hostname_fg"
    style_bg "$hostname_bg"
    prefix
    printf "%s" "$(hostname)"
    suffix
}
component_uptime() {
    style_text bold
    style_fg "$uptime_fg"
    style_bg "$uptime_bg"
    prefix
    printf "%s" "$(~/.local/share/bin/uptime.sh)"
    suffix
}
component_currentwindow() {
    style_text bold
    style_fg "$currentwindow_fg"
    style_bg "$currentwindow_bg"
    prefix
    printf "#W"
    suffix
}
component_seperator() {
    style_fg ""
    style_bg "$2"
    printf "%s" "$1"
}
component_prefix() {
    style_fg "$1"
    style_bg "$2"
    printf '#{?client_prefix, Prefix ,}'
    
}
component_currentwindow_or_prefix() {
    style_text bold
    style_fg "$currentwindow_fg"
    style_bg "$currentwindow_bg"
    prefix
    printf '%s' '#{?client_prefix,Prefix,#W}'
    suffix
}
