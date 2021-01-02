# echo "#[fg=#02B696]#[bg=#D5D5B0]#[bold]%d/%m %H:%M"

##### Style Variables #####
default_fg="#f8f8f2"
default_bg="#282a36"
default_prefix=" "
default_suffix=" "
date_fg="#f8f8f2"
date_bg="#bd93f9"
hostname_fg="#f8f8f2"
hostname_bg="#50fa7b"
uptime_fg="#f8f8f2"
uptime_bg="#ffb86c"
currentwindow_fg="#f8f8f2"
currentwindow_bg="#bd93f9"

##### Style Control #####
function style_text {
    printf "#[$1]"
}
function style_fg {
    printf "#[fg=#$1]"
}
function style_bg {
    printf "#[bg=#$1]"
}
function prefix {
    printf "$default_prefix"
}
function suffix {
    printf "$default_suffix"
}

function component_date {
    style_fg "$date_fg"
    style_bg "$date_bg"
    prefix
    printf "$(date -u +"%d/%m/%Y")"
    suffix
}
function component_hostname {
    style_text bold
    style_fg "$hostname_fg"
    style_bg "$hostname_bg"
    prefix
    printf "$(hostname)"
    suffix
}
function component_uptime {
    style_text bold
    style_fg "$uptime_fg"
    style_bg "$uptime_bg"
    prefix
    printf "$(uptime -p | awk -F',' '{print $1}')"
    suffix
}
function component_currentwindow {
    style_text bold
    style_fg "$currentwindow_fg"
    style_bg "$currentwindow_bg"
    prefix
    printf "#W"
    suffix
}
function component_seperator {
    style_fg ""
    style_bg "$2"
    printf "$1"
}
