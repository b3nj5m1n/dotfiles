#!/bin/bash

YES=false
if [[ "$1" == "YES" ]]; then
    YES=true
fi

# Colored output
output_err() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;31m$MODULE\e[1;0m] - [\e[1;91m$NAME\e[1;0m]: $DESC\e[1;0m\n"
}
output_warn() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;33m$MODULE\e[1;0m] - [\e[1;93m$NAME\e[1;0m]: $DESC\e[1;0m\n"
}
output_info() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;36m$MODULE\e[1;0m] - [\e[1;96m$NAME\e[1;0m]: \e[1;3m$DESC\e[1;0m\n"
}
output_sucs() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;32m$MODULE\e[1;0m] - [\e[1;92m$NAME\e[1;0m]: $DESC\e[1;0m\n"
}
prompt_yes_no() {
    if [[ $YES == true ]]; then
        return 0;
    fi
    MODULE=$1
    PROMPT=$2
    PROMPT=$(printf "[\e[1;35m$MODULE\e[1;0m] - \e[1;95m$PROMPT\e[1;0m? (yes/no) ")
    read -p "$PROMPT" yn
    case $yn in
        yes ) return 0;;
        no ) return 1;;
        * ) return 1;;
    esac
}

check_exists_package() {
    PACKAGE_NAME=$1
    HELP=$2
    ESSENTIAL=$3
    INSTALL_CMD=$4
    if pacman -Qs --quiet "$PACKAGE_NAME" | grep "^$PACKAGE_NAME$" > /dev/null; then
        output_sucs "PACKAGES" "$PACKAGE_NAME" "Package installed"
        return 0
    elif pacman -Qg "$PACKAGE_NAME" | grep "^$PACKAGE_NAME .*$" > /dev/null; then
        output_sucs "PACKAGES" "$PACKAGE_NAME" "Package installed"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "PACKAGES" "$PACKAGE_NAME" "Package not installed"
        else
            output_warn "PACKAGES" "$PACKAGE_NAME" "Package not installed (Not essential)"
        fi
        if ! [ -z "$INSTALL_CMD" ];
        then
            prompt_yes_no "PACKAGES" "Would you like to try to install this automatically"
            if ! [ $? = 0 ]; then
                return 1
            fi
            if [ "$INSTALL_CMD" = true ]; then
                paru --noconfirm --skipreview --needed -Sy "$PACKAGE_NAME"
                return 1
            fi
            "${INSTALL_CMD}"
        fi
        if [ -n "$HELP" ];
        then
            output_info "PACKAGES" "$PACKAGE_NAME" "$HELP"
        fi
        return 1
    fi
}

check_exists_font() {
    FONT_NAME=$1
    HELP=$2
    ESSENTIAL=$3
    if (fc-list -f '%{family[0]}\n' | grep "^$FONT_NAME\$" > /dev/null); then
        output_sucs "FONTS" "$FONT_NAME" "Font found"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "FONTS" "$FONT_NAME" "Font not found"
        else
            output_warn "FONTS" "$FONT_NAME" "Font not found (Not essential)"
        fi
        if [ -n "$HELP" ];
        then
            check_exists_package "$HELP" false false true
        fi
        return 1
    fi
}

check_exists_locale() {
    LOCALE=$1
    HELP=$2
    ESSENTIAL=$3
    if (locale -a | grep -q "^$LOCALE\$"); then
        output_sucs "LOCALES" "$LOCALE" "Locale active"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "LOCALES" "$LOCALE" "Locale not active"
        else
            output_warn "LOCALES" "$LOCALE" "Locale not active (Not essential)"
        fi
        if [ -n "$HELP" ];
        then
            output_info "LOCALES" "$LOCALE" "$HELP"
        fi
        return 1
    fi
}

check_exists_file() {
    FILE_PATH=$1
    HELP=$2
    ESSENTIAL=$3
    if [ -f "$FILE_PATH" ]; then
        output_sucs "FILE" "$FILE_PATH" "File exists"
        return 0
    elif [ -d "$FILE_PATH" ]; then
        output_sucs "FILE" "$FILE_PATH" "Directory exists"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "FILE" "$FILE_PATH" "File does not exist"
        else
            output_warn "FILE" "$FILE_PATH" "File does not exist (Not essential)"
        fi
        if [ -n "$HELP" ];
        then
            output_info "FILE" "$FILE_PATH" "$HELP"
        fi
        return 1
    fi
}

check_group() {
    # https://stackoverflow.com/a/46651233/11110290
    USER=$1
    GROUP=$2
    ESSENTIAL=$3
    if id -nGz "$USER" | grep -qzxF "$GROUP"; then
        output_sucs "GROUPS" "$GROUP" "$USER is part of $GROUP"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "GROUPS" "$GROUP" "$USER is not part of $GROUP"
        else
            output_warn "GROUPS" "$GROUP" "$USER is not part of $GROUP (Not essential)"
        fi
        output_info "GROUPS" "$GROUP" "usermod -aG $GROUP $USER"
        return 1
    fi
}

check_keyboard_layout() {
    LAYOUT=$1
    HELP=$2
    if [ "$(setxkbmap -query | grep layout | awk '{ print $2 }')" = "$LAYOUT" ]; then
        output_sucs "KEYBOARD-LAYOUT" "$LAYOUT" "Keyboard layout set"
        return 0
    else
        output_warn "KEYBOARD-LAYOUT" "$LAYOUT" "Keyboard layout not set"
        if [ -n "$HELP" ];
        then
            output_info "KEYBOARD-LAYOUT" "$LAYOUT" "$HELP"
        fi
        return 1
    fi
}

check_active_sysd() {
    SERVICE=$1
    HELP=$2
    ESSENTIAL=$3
    if systemctl is-active --quiet "$SERVICE"; then
        output_sucs "SYSTEMD" "$SERVICE" "Service active"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "SYSTEMD" "$SERVICE" "Service not active"
        else
            output_warn "SYSTEMD" "$SERVICE" "Service not active (Not essential)"
        fi
        if [ -n "$HELP" ];
        then
            output_info "SYSTEMD" "$SERVICE" "$HELP"
        fi
        return 1
    fi
}

check_env() {
    ENV=$1
    VAL=$2
    HELP=$3
    ESSENTIAL=$4
    if [[ $(printf '%s' "${!ENV}") == "$VAL" ]]; then
        output_sucs "ENV-VARS" "$ENV" "Set correctly"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "ENV-VARS" "$ENV" "Not set correctly"
        else
            output_warn "ENV-VARS" "$ENV" "Not set correctly (Not essential)"
        fi
        if [ -n "$HELP" ];
        then
            output_info "ENV-VARS" "$ENV" "$HELP"
        fi
        return 1
    fi
}

check_owner() {
    # https://stackoverflow.com/a/46651233/11110290
    OWNER=$1
    DIR=$2
    ESSENTIAL=$3
    if [[ $(fd --hidden . "$DIR" --owner "!$OWNER" | wc -l) = 0 ]]; then
        output_sucs "OWNER" "$OWNER" "$OWNER owns all of $DIR"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "OWNER" "$OWNER" "$OWNER doesn't own all of $DIR"
        else
            output_warn "OWNER" "$OWNER" "$OWNER doesn't own all of $DIR (Not essential)"
        fi
        output_info "OWNER" "$OWNER" "sudo chown -R $USER $DIR"
        return 1
    fi
}

install_paru() {
    CURRENT_DIR=$PWD
    output_info "AUTO-INSTALL" "paru" "Current directory: $CURRENT_DIR"
    cd /tmp
    output_info "AUTO-INSTALL" "paru" "Making sure all needed packages are installed"
    sudo pacman -S --needed base-devel git rustup
    rustup install nightly
    output_info "AUTO-INSTALL" "paru" "Cloning paru repository"
    git clone https://aur.archlinux.org/paru.git
    cd paru
    output_info "AUTO-INSTALL" "paru" "Installing paru"
    makepkg -si
    output_info "AUTO-INSTALL" "paru" "Switching back to original directory"
    cd "$CURRENT_DIR"
}

check_not_exists_file() {
    FILE_PATH=$1
    HELP=$2
    if [ -f "$FILE_PATH" ]; then
        output_warn "FILE" "$FILE_PATH" "File exists, but shouldn't. You may be able to take steps to remove it."
        if [ -n "$HELP" ];
        then
            output_info "FILE" "$FILE_PATH" "$HELP"
        fi
        return 1
    elif [ -d "$FILE_PATH" ]; then
        output_warn "FILE" "$FILE_PATH" "Directory exists, but shouldn't. You may be able to take steps to remove it."
        if [ -n "$HELP" ];
        then
            output_info "FILE" "$FILE_PATH" "$HELP"
        fi
        return 1
    else
        output_sucs "FILE" "$FILE_PATH" "File doesn't exists (it shouldn't)."
        return 0
    fi
}

# Basic system functionality
check_exists_package "pacman" "If this is missing you're in big trouble. Or not on an arch based distro." true
check_exists_package "paru" "Setup is heavily dependent on the AUR, so paru is needed." true install_paru
check_exists_package "git" "" true true
check_exists_package "base-devel" "" true true
check_group "$USER" "wheel" true
check_exists_package "grub" "" true true
check_exists_package "fontconfig" "" true true
check_exists_package "cronie" "" true true
check_exists_package "acpi" "" false true
check_exists_package "rsync" "" false true
check_exists_package "usbutils" "" false true
check_exists_package "wget" "" false true
check_exists_package "jq" "" false true
check_exists_locale "en_GB.utf8" "" true
check_exists_locale "de_DE.utf8" "" false
check_active_sysd "lightdm" "GUI won't be available (Not necessary if lightdm-plymouth is enabled)" false
check_active_sysd "lightdm-plymouth" "GUI won't be available (Not necessary if lightdm is enabled)" false
check_active_sysd "sshd" "Won't be able to connect via ssh"

# Networking
check_exists_package "inetutils" "" true true
check_exists_package "dhcpcd" "" true true
check_exists_package "iwd" "" false true
check_active_sysd "dhcpcd" "Ethernet won't work" true
check_active_sysd "systemd-networkd" "" false
check_active_sysd "systemd-resolved" "" false

# Command Line
check_exists_package "zsh" "" true true
check_exists_package "tmux" "" true true
check_exists_package "neovim-git" "" true true
check_exists_package "zoxide" "" true true
check_exists_package "atuin" "" true true
check_exists_package "starship" "" true true
check_exists_package "exa" "" true true
check_exists_package "ripgrep" "" true true
check_exists_package "fd" "" true true
check_exists_package "bat" "" true true
check_exists_package "bottom" "" true true
check_exists_package "neomutt" "" false true
check_exists_package "ncmpcpp" "" false true
check_exists_package "task" "" false true
check_exists_package "timew" "" false true
check_exists_package "keychain" "" false true
check_exists_package "pfetch-git" "" false true
check_exists_package "thefuck" "" false true
check_exists_package "difftastic" "" false true
check_exists_package "mpd" "" false true
check_exists_package "mpc" "" false true
check_exists_package "rofi-greenclip" "" false true
check_exists_package "tealdeer" "" false true
check_exists_package "mlocate" "" false true
check_exists_package "glow" "" false true
check_exists_package "sd" "" false true
check_exists_package "skim" "" false true
check_exists_package "duf" "" false true
check_exists_package "hyperfine" "" false true
check_env "SHELL" "/bin/zsh" "" true
check_env "EDITOR" "nvim" "" true
check_exists_file "/usr/share/terminfo/a/alacritty-full" "Run compile-terminfo.sh script in files/terminfo." true
check_exists_file "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "Install zsh-syntax-highlighting-git aur package" true
check_exists_file "/home/$USER/.local/share/nvim/site/pack/packer" "Install nvim-packer-git aur package" true

# Dotfiles
check_exists_package "dotter-rs-bin" "" true true

# Docker
check_group "$USER" "docker"

# Graphical Environment
check_exists_package "xorg" "" true true
check_exists_package "lightdm" "" true true
check_exists_package "bspwm" "" false true
check_exists_package "sxhkd" "" false true
check_exists_package "polybar" "" false true
check_exists_package "dunst" "" false true
check_keyboard_layout "de" "setxkbmap de"
check_exists_package "xclip" "" true true
check_exists_package "alsa-utils" "" true true
check_exists_package "pulseaudio" "" true true
check_exists_package "plymouth-git" "" true true
check_exists_package "plymouth-theme-dotlock" "" true true
check_exists_package "alacritty" "" false true
check_exists_package "firefox" "" false true
check_exists_package "picom" "" false true
check_exists_package "redshift" "" false true
check_exists_package "rofi" "" false true
check_exists_package "zathura" "" false true
check_exists_package "feh" "" true true
check_exists_package "devour" "" true true
check_exists_package "unclutter" "" false true
check_exists_package "rofi-calc" "" false true
check_exists_package "thunar" "" false true
check_exists_package "peek" "" false true
check_exists_font "FantasqueSansMono Nerd Font" "nerd-fonts-fantasque-sans-mono" true
check_exists_font "FiraCode Nerd Font" "nerd-fonts-fira-code"
check_exists_font "FiraCode Nerd Font Mono" "nerd-fonts-fira-mono"
check_exists_font "UbuntuMono Nerd Font" "nerd-fonts-ubuntu-mono"
check_exists_file "$(/bin/cat files/bspwm/bspwmrc | /bin/grep "feh" | /bin/sed -r 's/feh --no-fehbg --bg-scale (.*) &/\1/')" "Clone & install bigconf" true

# Firmware
check_exists_package "pod2man" "" false true # This is needed for python-validity, but not specified as a dependency
check_exists_package "python-validity" "" false true # This is needed for python-validity, but not specified as a dependency
check_exists_package "fprint" "" false true
check_active_sysd "python3-validity" "Thinkpad fingerprint driver"

# Security

check_exists_file "/home/$USER/.ssh/id_rsa" "No rsa ssh key found" false
check_exists_file "/home/$USER/.ssh/id_ed25519" "No ed25519 ssh key found" false
check_exists_package "yubikey-manager" "" false true
check_exists_package "libfido2" "" false true

# Language-specific Development Packages

## Bash
check_exists_package "bash-language-server" "" false true
check_exists_package "shellcheck" "" false true

## C/C++
check_exists_package "clang" "" false true

## Haskell
check_exists_package "ghc" "" false true
check_exists_package "ghc-static" "" false true
check_exists_package "ghc-libs" "" false true
check_exists_package "haskell-language-server" "" false true
check_exists_package "cabal-install" "" false true

## Common Lisp
check_exists_package "clisp" "" false true
check_exists_package "roswell" "" false true

## Web
check_exists_package "npm" "" false true
check_exists_package "yarn" "" false true
check_exists_package "elm-platform-bin" "" false true
check_exists_package "typescript" "" false true
check_exists_package "typescript-language-server" "" false true
check_exists_package "vscode-html-languageserver" "" false true
check_exists_package "vscode-css-languageserver" "" false true

## Java *shudder*
check_exists_package "jdk-openjdk" "" false true
check_exists_package "jre-openjdk" "" false true
check_exists_package "jdtls" "" false true
check_owner "$USER" "/usr/share/java/jdtls" false # Needed for jdtls to function properly

## Lua
check_exists_package "lua" "" false true
check_exists_package "luajit" "" false true
check_exists_package "luarocks" "" false true
check_exists_package "lua-language-server-git" "" false true
check_exists_package "fennel" "" false true
check_exists_package "fnlfmt" "" false true

## Rust
check_exists_package "rustup" "" false true
check_exists_package "rust-analyzer" "" false true
