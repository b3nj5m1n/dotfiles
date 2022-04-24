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

check_group() {
    # https://stackoverflow.com/a/46651233/11110290
    USER=$1
    GROUP=$2
    ESSENTIAL=$3
    if id -nGz "$USER" | grep -qzxF "$GROUP"; then
        output_sucs "GROUPS" "$GROUP" "$USER is part of $GROUP"
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

# Package Manager

check_exists_package "pacman" "If this is missing you're in big trouble. Or not on an arch based distro." true
check_exists_package "paru" "Setup is heavily dependent on the AUR, so paru is needed." true

# Groups

check_group "$USER" "wheel" true
check_group "$USER" "docker"

# Essential Packages

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

# Fonts

check_exists_font "FantasqueSansMono Nerd Font" "(aur) nerd-fonts-fantasque-sans-mono" true
check_exists_font "FiraCode Nerd Font" "(aur) nerd-fonts-fira-code"
check_exists_font "FiraCode Nerd Font Mono" "(aur) nerd-fonts-fira-mono"
check_exists_font "UbuntuMono Nerd Font" "(aur) nerd-fonts-ubuntu-mono"
