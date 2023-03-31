#! /usr/bin/env nix-shell
#! nix-shell -i dash -p dash gum wireguard-tools figlet lolcat fd qrencode

set -e

figlet -f cybermedium "Wireguard management script" | lolcat

COLOR_ERROR="#ed8796"
COLOR_WARNING="#eed49f"
COLOR_INFO="#8aadf4"

# Remove possible trailing slash from XDG_DATA_HOME enviornment variable
XDG_DATA_HOME="${XDG_DATA_HOME%/}"

# Location where public/private wireguard keys will be stored
WG_KEYS_LOCATION="${XDG_DATA_HOME:-~/.local/share}/wireguard"

if [ -d "$WG_KEYS_LOCATION" ]
then
  gum format -t template "{{ Color \"$COLOR_INFO\" \"Found key location at\" }} {{ Italic \"$WG_KEYS_LOCATION\" }}"
  echo ""
else
  gum format -t template "{{ Color \"$COLOR_WARNING\" \"Key location\" }} {{ Italic \"$WG_KEYS_LOCATION\" }} {{ Color \"$COLOR_WARNING\" \"not found\" }}"
  echo ""
  if gum confirm "Create now?"
  then
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Creating directory at\" }} {{ Italic \"$WG_KEYS_LOCATION\" }}"
    echo ""
    mkdir -p "$WG_KEYS_LOCATION"
  else
    gum format -t template "{{ Color \"$COLOR_ERROR\" \"Can't continue without directory for keys, either manually create the directory at\" }} {{ Italic \"$WG_KEYS_LOCATION\" }} {{ Color \"$COLOR_ERROR\" \"or edit your\" }} {{ Italic \"\$XDG_DATA_HOME\" }} {{ Color \"$COLOR_ERROR\" \"environment variable\" }}"
    echo ""
  fi
fi

# TODO check UID on $WG_KEYS_LOCATION

echo "What do you want to do?"

OPTION_NEW="Create new keypair"
OPTION_DISPLAY="Display public key"
OPTION_QR="Show peer config (QR)"
OPTION_CONFIG="Show peer config"
option=$(printf "%s\n%s\n%s\n%s\n" "$OPTION_NEW" "$OPTION_DISPLAY" "$OPTION_QR" "$OPTION_CONFIG" | gum choose)

# This gets a list of key names. It assumes that a key has a name.public
# and name.private file in $WG_KEYS_LOCATION
KEYS="$(fd -e private . "$WG_KEYS_LOCATION" | awk -F ".private" '{print $1}' | while read -r prefix; do test -e "${prefix}.public" && basename "${prefix}"; done)"

TMPFILE=""

create_peer_config() {
  server_ip="$(gum input --placeholder "What is the server's public IP address?")"
  server_port="$(gum input --placeholder "On which (publicly exposed) port is WireGuard running on the server?")"
  peer_local_ip="$(gum input --placeholder "What IP address should be assigned to the peer in the local network when connecting to the VPN?")"
  dns="$(gum input --placeholder "What DNS server (IP) should the peer use when connected to the VPN?")"
  gum format -t template "{{ Color \"$COLOR_INFO\" \"Select the server's key pair:\n\" }}"
  key_name_server="$(echo "$KEYS" | gum choose)"
  gum format -t template "{{ Color \"$COLOR_INFO\" \"Select the peer's key pair:\n\" }}"
  key_name_peer="$(echo "$KEYS" | gum choose)"
  TMPFILE=$(mktemp)
  cat << EOF > "$TMPFILE"
[Interface]
PrivateKey = $(cat "$WG_KEYS_LOCATION/$key_name_peer.private")
Address = $peer_local_ip
DNS = $dns

[Peer]
PublicKey = $(cat "$WG_KEYS_LOCATION/$key_name_server.public")
Endpoint = $server_ip:$server_port
AllowedIPs = 0.0.0.0/0
EOF
}

case "$option" in
  "$OPTION_NEW")
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Creating new keypair\" }}"
    echo ""
    keypair_name="$(gum input --placeholder "Name of keypair")"
    # TODO check if key already exists
    wg genkey | sudo tee "$WG_KEYS_LOCATION/$keypair_name.private" | wg pubkey | sudo tee "$WG_KEYS_LOCATION/$keypair_name.public" > /dev/null
    gum format -t template "{{ Color \"$COLOR_INFO\" \"New keypair created\" }}"
    echo ""
    gum format -t template "{{ Italic \"$WG_KEYS_LOCATION/$keypair_name.private\" }}"
    echo ""
    gum format -t template "{{ Italic \"$WG_KEYS_LOCATION/$keypair_name.public\" }}"
    echo ""
    ;;
  "$OPTION_DISPLAY")
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Displaying public key\" }}"
    echo ""
    key_name="$(echo "$KEYS" | gum choose)"
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Public key for $key_name\" }} {{ Background \"$COLOR_ERROR\" \"$(cat "$WG_KEYS_LOCATION/$key_name.public")\" }}"
    echo ""
    ;;
  "$OPTION_QR")
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Showing peer config as QR code\n\" }}"
    create_peer_config
    qrencode -t ansiutf8 < "$TMPFILE"
    ;;
  "$OPTION_CONFIG")
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Showing peer config\n\" }}"
    create_peer_config
    gum format -t template "{{ Color \"$COLOR_INFO\" \"Config stored in\n\" }} {{ Italic \"$TMPFILE\" }}"
    cat "$TMPFILE"
    ;;
esac
