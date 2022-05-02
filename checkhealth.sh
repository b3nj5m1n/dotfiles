#!/bin/bash

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
    COMMAND_NAME=$1
    PACKAGE_NAME=$2
    ESSENTIAL=$3
    INSTALL_CMD=$4
    if [ -x "$(command -v $COMMAND_NAME)" ]; then
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
                paru --noconfirm --skipreview -Sy "$PACKAGE_NAME"
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
            check_exists_package false "$HELP" false true
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
    PATH=$1
    HELP=$2
    ESSENTIAL=$3
    if [ -f "$PATH" ]; then
        output_sucs "FILE" "$PATH" "File exists"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "FILE" "$PATH" "File does not exist"
        else
            output_warn "FILE" "$PATH" "File does not exist (Not essential)"
        fi
        if [ -n "$HELP" ];
        then
            output_info "FILE" "$PATH" "$HELP"
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

# Package Manager

check_exists_package "pacman" "If this is missing you're in big trouble. Or not on an arch based distro." true

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
check_exists_package "paru" "Setup is heavily dependent on the AUR, so paru is needed." true install_paru

# Groups

check_group "$USER" "wheel" true
check_group "$USER" "docker"

# Keyboard layout

check_keyboard_layout "de" "setxkbmap de"

# Essential Packages

check_exists_package "sudo" "base-devel" true true
check_exists_package "fakeroot" "base-devel" true true
check_exists_package "ld" "base-devel" true true
check_exists_package "hostname" "inetutils" true true
check_exists_package "dhcpcd" "dhcpcd" true true
check_exists_package "iwctl" "iwd" false true
check_exists_package "grub-mkconfig" "grub" true true
check_exists_package "nvim" "neovim-git" true true
check_exists_package "xclip" "xclip" true true
check_exists_package "zsh" "zsh" true true
check_exists_package "tmux" "tmux" true true
check_exists_package "git" "git" true true
check_exists_package "exa" "exa" true true
check_exists_package "zoxide" "zoxide" true true
check_exists_package "rg" "ripgrep" true true
check_exists_package "fd" "fd" true true
check_exists_package "bat" "bat" true true
check_exists_package "btm" "bottom" true true
check_exists_package "dotter" "dotter-rs-bin" true true
check_exists_package "fc-list" "fontconfig" true true
check_exists_package "starship" "starship" true true
check_exists_package "atuin" "atuin" true true
check_exists_package "Xorg" "xorg" true true
check_exists_package "lightdm" "lightdm" true true
check_exists_package "crond" "cronie" true true
check_exists_package "feh" "feh" true true
check_exists_package "devour" "devour" true true

# Non-Essential Packages

check_exists_package "alacritty" "alacritty" false true
check_exists_package "bspwm" "bspwm" false true
check_exists_package "sxhkd" "sxhkd" false true
check_exists_package "polybar" "polybar" false true
check_exists_package "dunst" "dunst" false true
check_exists_package "firefox" "firefox" false true
check_exists_package "neomutt" "neomutt" false true
check_exists_package "ncmpcpp" "ncmpcpp" false true
check_exists_package "picom" "picom" false true
check_exists_package "redshift" "redshift" false true
check_exists_package "rofi" "rofi" false true
check_exists_package "task" "task" false true
check_exists_package "timew" "timew" false true
check_exists_package "zathura" "zathura" false true
check_exists_package "keychain" "keychain" false true

# Locales

check_exists_locale "en_GB.utf8" "" true
check_exists_locale "de_DE.utf8" "" false

# Services
check_active_sysd "lightdm" "GUI won't be available (Not necessary if lightdm-plymouth is enabled)" false
check_active_sysd "lightdm-plymouth" "GUI won't be available (Not necessary if lightdm is enabled)" false
check_active_sysd "dhcpcd" "Ethernet won't work" true
check_active_sysd "systemd-networkd" "" false
check_active_sysd "systemd-resolved" "" false
check_active_sysd "sshd" "Won't be able to connect via ssh"

# Environment Variables

check_env "SHELL" "/bin/zsh" "" true
check_env "EDITOR" "nvim" "" true

# Fonts

check_exists_font "FantasqueSansMono Nerd Font" "nerd-fonts-fantasque-sans-mono" true
check_exists_font "FiraCode Nerd Font" "nerd-fonts-fira-code"
check_exists_font "FiraCode Nerd Font Mono" "nerd-fonts-fira-mono"
check_exists_font "UbuntuMono Nerd Font" "nerd-fonts-ubuntu-mono"

# Files

check_exists_file "/usr/share/terminfo/a/alacritty-full" "Run compile-terminfo.sh script in files/terminfo." true
check_exists_file "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "Install zsh-syntax-highlighting-git aur package" true
check_exists_file "$(/bin/cat files/bspwm/bspwmrc | /bin/grep "feh" | /bin/sed -r 's/feh --bg-scale (.*) &/\1/')" "Clone & install bigconf" true
