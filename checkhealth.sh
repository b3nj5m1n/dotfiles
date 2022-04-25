#!/bin/bash

# Colored output
output_err() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;31m$MODULE\e[1;0m] - [\e[1;91m$NAME\e[1;0m]: $DESC\n"
}
output_warn() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;33m$MODULE\e[1;0m] - [\e[1;93m$NAME\e[1;0m]: $DESC\n"
}
output_info() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;36m$MODULE\e[1;0m] - [\e[1;96m$NAME\e[1;0m]: \e[1;3m$DESC\n"
}
output_sucs() {
    MODULE=$1
    NAME=$2
    DESC=$3
    printf "[\e[1;32m$MODULE\e[1;0m] - [\e[1;92m$NAME\e[1;0m]: $DESC\n"
}

check_exists_package() {
    PACKAGE_NAME=$1
    HELP=$2
    ESSENTIAL=$3
    if [ -x "$(command -v $PACKAGE_NAME)" ]; then
        output_sucs "PACKAGES" "$PACKAGE_NAME" "Package installed"
        return 0
    else
        if [ "$ESSENTIAL" = true ]; then
            output_err "PACKAGES" "$PACKAGE_NAME" "Package not installed"
        else
            output_warn "PACKAGES" "$PACKAGE_NAME" "Package not installed (Not essential)"
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
            output_info "FONTS" "$FONT_NAME" "$HELP"
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
check_exists_package "paru" "Setup is heavily dependent on the AUR, so paru is needed." true

# Groups

check_group "$USER" "wheel" true
check_group "$USER" "docker"

# Keyboard layout

check_keyboard_layout "de" "setxkbmap de"

# Essential Packages

check_exists_package "sudo" "base-devel" true
check_exists_package "fakeroot" "base-devel" true
check_exists_package "ld" "base-devel" true
check_exists_package "dhcpcd" "dhcpcd" true
check_exists_package "iwctl" "iwd" false
check_exists_package "grub-mkconfig" "grub" true
check_exists_package "nvim" "(aur) neovim-git" true
check_exists_package "zsh" "zsh" true
check_exists_package "tmux" "tmux" true
check_exists_package "git" "git" true
check_exists_package "exa" "exa" true
check_exists_package "zoxide" "zoxide" true
check_exists_package "rg" "ripgrep" true
check_exists_package "fd" "fd" true
check_exists_package "bat" "bat" true
check_exists_package "dotter" "(aur) dotter-rs-bin" true

# Locales

check_exists_locale "en_GB.utf8" "" true
check_exists_locale "de_DE.utf8" "" false

# Services

check_active_sysd "dhcpcd" "Ethernet won't work" true
check_active_sysd "systemd-networkd" "" false
check_active_sysd "systemd-resolved" "" false
check_active_sysd "sshd" "Won't be able to connect via ssh"

# Environment Variables

check_env "EDITOR" "nvim" "" true

# Fonts

check_exists_font "FantasqueSansMono Nerd Font" "(aur) nerd-fonts-fantasque-sans-mono" true
check_exists_font "FiraCode Nerd Font" "(aur) nerd-fonts-fira-code"
check_exists_font "FiraCode Nerd Font Mono" "(aur) nerd-fonts-fira-mono"
check_exists_font "UbuntuMono Nerd Font" "(aur) nerd-fonts-ubuntu-mono"
