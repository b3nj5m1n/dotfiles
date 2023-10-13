#!/usr/bin/env sh

# Creates a blue screen of death when laptop battery needs to be swapped
# Run by systemd unit on a timer (see battery-thing.nix)

# if [ "$(id -u)" -ne 0 ]; then
#   echo "This script must be run as root"
#   exit 1
# fi

# # Check if battery level is below 60%
# battery_level=$(cat /sys/class/power_supply/BAT0/capacity)
# if [ "$battery_level" -gt 60 ]; then
#     exit
# fi

# Check if battery is discharging
battery_status=$(cat /sys/class/power_supply/BAT0/status)
if [ "$battery_status" != "Discharging" ]; then
    exit
fi

chvt 4
echo -e "\033c" | tee /dev/tty4

cols=$(stty -F /dev/tty4 size | cut -d' ' -f2)
rows=$(stty -F /dev/tty4 size | cut -d' ' -f1)

printf "\033[44m" | tee /dev/tty4

x="$rows"
y="$cols"

middle_row=$((x / 2 + 1))

for i in $(seq 1 "$x"); do
  if [ "$i" -eq "$middle_row" ]; then
    text="WARNING: SWAP BATTERY"
    padding=$(( (y - ${#text}) / 2 ))
    row=""
    for j in $(seq 1 "$padding"); do
      row="${row} "
    done
    row="${row}${text}"
    printf "%s" "$row" | tee /dev/tty4
  else
    row=""
    for j in $(seq 1 "$y"); do
      row="${row} "
    done
    printf "%s" "$row" | tee /dev/tty4
  fi
done
