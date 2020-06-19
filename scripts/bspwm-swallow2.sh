#!/bin/sh

swallowable=" $TERMINAL urxvt kitty "
blacklist=" $swallowable " # you don't want to swallow a swalloer right?
verbose=0

swallow() {
        cwid="$1"; pwid="$2"; cname="$3"; pname="$4";
        [ "${swallowable#* $pname}" != "$swallowable" ] || return
        [ "${blacklist#* $cname }" != "$blacklist" ] && return
        bspc node "$pwid" --flag hidden=on                      #*
        [ "$verbose" -eq 1 ] && echo "$cname($cwid) swallowed $pname($pwid)"
        echo "$pwid" > "/tmp/swallowed-by-$cwid"
}

vomit() {
        cwid="$1"
        [ -f "/tmp/swallowed-by-$cwid" ] || return 0
        pwid=$(< "/tmp/swallowed-by-$cwid")
        bspc node "$pwid" --flag hidden=off  -f                  #*
        [ "$verbose" -eq 1 ] && echo "$cwid vomited $pwid"
        rm "/tmp/swallowed-by-$cwid"; return 0
}

cwid="$1"
cpid=$(xprop _NET_WM_PID -id "$cwid" 2>/dev/null)

[ "$?" -ne 0 ] && vomit "$cwid" && exit
cpid="${cpid##* }"
cname="$(ps -e | grep "$cpid")"; cname="${cname##* }"
ptree="$(pstree -ATsp $cpid)"; ptree="${ptree#*---}"
[ "$verbose" -eq 1 ] && echo "$ptree"
parent="${ptree%%---*}"; pname="${parent%%(*}";
ppid="${parent##*(}"; ppid="${ppid%)}"
[ -z "$ppid" ] && \
        "pls report this issue to https://github.com/liupold/pidswallow" && exit
pwid="$(xdotool search --pid $ppid 2>/dev/null)"
swallow "$cwid" "$pwid" "$cname" "$pname"
