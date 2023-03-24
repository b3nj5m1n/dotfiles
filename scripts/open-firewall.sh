#!/usr/bin/env sh

# Toggle allowing traffic on a certain port

PORT="$1"
TABLE_NAME="nixos-fw"

MODE="$2"

if [ "$EUID" -ne 0 ]; then
  echo "This script must be run as root"
  exit 1
fi

handle=$(nft -a list chain inet nixos-fw input | grep "dport 30006 accept" | awk '{print $NF}')

open() {
  nft insert rule inet "$TABLE_NAME" input tcp dport "$PORT" accept
}
close() {
  nft delete rule inet "$TABLE_NAME" input handle "$handle"
}

case "$MODE" in
  0|"toggle")
    if [ -n "$handle" ]; then
        echo "Port currently open, closing..."
        close
    else
        echo "Port currently closed, opening..."
        open
    fi
    ;;
  1|"open")
    echo "Opening port..."
    open
    ;;
  2|"close")
    echo "Closing port..."
    close
    ;;
  *)
    echo "Invalid mode: $MODE"
    ;;
esac
