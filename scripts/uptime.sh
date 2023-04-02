#!/usr/bin/env sh

# Pass true as first argument to get long form

seconds_uptime=$(awk '{print int($1)}' /proc/uptime)
seconds_in_year=31556952; seconds_in_month=2629746; seconds_in_day=86400; seconds_in_hour=3600; seconds_in_minute=60;

# The delimiter between 12 and hours
DELIMITER_UNIT=""
# The delimiter between 12 hours and 6 minutes
DELIMITER_VALUES=" "

# If we want the long form
if [ "$1" ]; then DELIMITER_UNIT=" "; DELIMITER_VALUES=", "; fi

unit_s_y="y"; unit_p_y="y" unit_s_mo="mo"; unit_p_mo="mo" unit_s_d="d"; unit_p_d="d" unit_s_h="h"; unit_p_h="h" unit_s_mi="m"; unit_p_mi="m";
if [ "$1" ]; then unit_s_y="year"; unit_p_y="years" unit_s_mo="month"; unit_p_mo="months" unit_s_d="day"; unit_p_d="days" unit_s_h="hour"; unit_p_h="hours" unit_s_mi="minute"; unit_p_mi="minutes"; fi

print_value() {
    if [ "$seconds_uptime" -ge "$1" ]; then
        value=$((seconds_uptime / $1))
        seconds_uptime=$((seconds_uptime - ( $1 * value )))
        unit="$2"
        if [ "$value" -gt "1" ]; then unit="$3"; fi
        if [ "$4" ]; then delimiter_values=""; else delimiter_values="$DELIMITER_VALUES"; fi
        printf "%d%s%s%s" "$value" "$DELIMITER_UNIT" "$unit" "$delimiter_values"
    fi
}

print_value "$seconds_in_year" "$unit_s_y" "$unit_p_y"
print_value "$seconds_in_month" "$unit_s_mo" "$unit_p_mo"
print_value "$seconds_in_day" "$unit_s_d" "$unit_p_d"
print_value "$seconds_in_hour" "$unit_s_h" "$unit_p_h"
print_value "$seconds_in_minute" "$unit_s_mi" "$unit_p_mi"
# print_value "$seconds_in_second" "$unit_s_s" "$unit_p_s" true
