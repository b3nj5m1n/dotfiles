# XDG enviorment variables
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

############### Enviorment Variables ###############

# Default Programs
export EDITOR=nvim
export FUZZY_FINDER=sk

# Use vim keybindings for mcfly
export MCFLY_KEY_SCHEME=vim

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Default/Prefered gpg profile to use
export DFGPGPROFILE="9F7D2083BB220CEEB720E068309D4C8689849C5B"

# Use bat for colorized manpages
export MANPAGER="sh -c 'col -bx | bat --theme=Dracula -l man -p'"

export TERM=alacritty-full

# {{#if force_terminfo}}
# # Enable tmux & emacs to run properly
# export TERM=xterm-256color-full
# {{/if}}


############### Colors ###############

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
PURPLE='\033[0;35m'
LGREEN='\033[1;32m'
LORANGE='\033[1;33m'
LBLUE='\033[1;34m'
LPURPLE='\033[1;35m'
LCYAN='\033[1;36m'
NC='\033[0m'


############### Functions ###############

function update_normal_pacman {
    pacman -Syy
}
function update_normal {
    yay -Syy
}
function upgrade_normal_pacman {
    pacman -Quq | while read p; do pacman -S $p --noconfirm --needed || echo $p >>pacman-failed.log; done
}
function upgrade_normal {
    yay -Quq --repo | while read p; do yay -S $p --noconfirm --noremovemake --nocleanafter --answerclean None --answerdiff None --answeredit None --needed --sudoloop || echo $p >>yay-failed.log; done
}
function upgrade_aur {
    yay -Quq --aur | while read p; do yay -S $p --noconfirm --noremovemake --nocleanafter --answerclean None --answerdiff None --answeredit None --needed --sudoloop || echo $p >>yay-failed.log; done
}
function update {
    update_normal
    upgrade_normal
    upgrade_aur
}

# Show an interacitve help menu with all defined and commented aliases
function alias_help {
    /usr/bin/cat ~/.config/shrc | grep -E "alias \w+='.+' #" | /usr/bin/sed -n -r 's/alias (\w+)=.+# (.+)$/\1 - \2/p' | $FUZZY_FINDER
    # You could also write this as an alias like this:
    # alias ahelp='/usr/bin/cat ~/.config/shrc | grep "alias \w+='\''.+'\'' #" | /usr/bin/sed -n -r '\''s/alias (\w+)=.+# (.+)$/\1 - \2/p'\'' | $FUZZY_FINDER' # List all available aliases
}

# Tries to compile (Or convert) the given document, first argument should be the location of the file to compile, the second argument (optionally) the path for the output
function compile {
    # Get the absolute path to the input file
    path_input=$(readlink -f "$1")
    printf "${LPURPLE}[compile]${NC}:${YELLOW} Compiling file:${NC}${LGREEN} ${path_input}${YELLOW}.\n"
    # Extract the extension
    extension_input=$(/usr/bin/sed -r 's/^.*\.//' <<< "$path_input")
    format_input=""
    format_input_pretty=""
    extension_output=""
    format_output=""
    format_output_pretty=""
    # Determine formats for input & output based on file extensions
    case "$extension_input" in
        "md")
            format_input="markdown"
            format_input_pretty="Markdown (.md)"
            ;;
        "org")
            format_input="org"
            format_input_pretty="Emacs Org-Mode (.org)"
            ;;
        "tex")
            format_input="latex"
            format_input_pretty="LaTeX (.tex)"
            ;;
        "html")
            format_input="html"
            format_input_pretty="Hypertext Markup Language (.html)"
            ;;
        "c")
            format_input="c"
            format_input_pretty="C (.c)"
            ;;
        "cpp")
            format_input="c++"
            format_input_pretty="C++ (.cpp)"
            ;;
        "rs")
            format_input="rust"
            format_input_pretty="Rust (.rs)"
            ;;
        *)
            printf "${LPURPLE}[compile]${NC}:${RED} Input format not recognized.\n"
            return 1
            ;;
    esac
    if [ -z "$2" ]
    then
        # Use default output format
        case "$extension_input" in
            "md")
                extension_output="pdf"
                format_output="pdf"
                format_output_pretty="Portable Document Format (.pdf)"
                ;;
            "org")
                extension_output="pdf"
                format_output="pdf"
                format_output_pretty="Portable Document Format (.pdf)"
                ;;
            "tex")
                extension_output="pdf"
                format_output="pdf"
                format_output_pretty="Portable Document Format (.pdf)"
                ;;
            "c")
                extension_output="bin"
                format_output="bin"
                format_output_pretty="Binary (.bin)"
                ;;
            "cpp")
                extension_output="bin"
                format_output="bin"
                format_output_pretty="Binary (.bin)"
                ;;
            "rs")
                extension_output="bin"
                format_output="bin"
                format_output_pretty="Binary (.bin)"
                ;;
            *)
                printf "${LPURPLE}[compile]${NC}:${RED} No default output format specified.\n"
                return 1
                ;;
        esac
        path_output=$(/usr/bin/sed -r "s/$extension_input$/$extension_output/" <<< "$path_input")
    else
        # Use user defined output format
        extension_output=$(/usr/bin/sed -r 's/^.*\.//' <<< "$2")
        case "$extension_output" in
            "md")
                format_output="markdown"
                format_output_pretty="Markdown (.md)"
                ;;
            "org")
                format_output="org"
                format_output_pretty="Emacs Org-Mode (.org)"
                ;;
            "tex")
                format_output="latex"
                format_output_pretty="LaTeX (.tex)"
                ;;
            "html")
                format_output="html"
                format_output_pretty="Hypertext Markup Language (.html)"
                ;;
            "bin")
                format_output="binary"
                format_output_pretty="Binary (.bin)"
                ;;
            *)
                printf "${LPURPLE}[compile]${NC}:${RED} Output format not recognized.\n"
                return 1
                ;;
        esac
        path_output="$2"
    fi
    # Give a status report
    printf "${LPURPLE}[compile]${NC}:${YELLOW} Compiling from input (${NC}${LGREEN}${format_input_pretty}${YELLOW}) to ${NC}${LGREEN}${format_output_pretty}${YELLOW} to ${NC}${LGREEN}${path_output}${YELLOW}...\n"
    # Compile the file
    case "$extension_input" in
        "md")
            pandoc --standalone --from "$format_input" --to "$format_output" --output "$path_output" "$path_input" 
            ;;
        "org")
            pandoc --standalone --from "$format_input" --to "$format_output" --output "$path_output" "$path_input" 
            ;;
        "tex")
            pdflatex --interaction nonstopmode "$path_input" "$path_output"
            ;;
        "c")
            gcc "$path_input" -o "$path_output"
            ;;
        "cpp")
            g++ "$path_input" -o "$path_output"
            ;;
        "rs")
            rustc "$path_input" -o "$path_output"
            ;;
    esac
    printf "${LPURPLE}[compile]${NC}:${YELLOW} Done.${NC}\n"
}

function run {
    # Get the absolute path to the input file
    path_input=$(readlink -f "$1")
    printf "${LBLUE}[run]${NC}:${YELLOW} Running file:${NC}${LGREEN} ${path_input}${YELLOW}.\n"
    # Extract the extension
    extension_input=$(/usr/bin/sed -r 's/^.*\.//' <<< "$path_input")
    format_input=""
    format_input_pretty=""
    program=""
    # Determine formats for input & program to use for opening based on file extensions
    case "$extension_input" in
        "pdf")
            format_input="pdf"
            format_input_pretty="Portable Document Format (.pdf)"
            ;;
        "bin")
            format_input="bin"
            format_input_pretty="Binary (.bin)"
            ;;
        *)
            printf "${LBLUE}[run]${NC}:${RED} Input format not recognized.\n"
            return 1
            ;;
    esac
    if [ -z "$2" ]
    then
        # Use default program for opening
        case "$extension_input" in
            "pdf")
                program="zathura"
                ;;
            "bin")
                program=""
                ;;
            *)
                printf "${LBLUE}[run]${NC}:${RED} No default program specified.\n"
                return 1
                ;;
        esac
    else
        # Use user defined program
        program="$2"
    fi
    # Give a status report
    printf "${LBLUE}[run]${NC}:${YELLOW} Running (${NC}${LGREEN}${path_input}${YELLOW}) using ${NC}${LGREEN}${program}${YELLOW}...\n"
    # Run the file
    if [ -z "$program" ]
    then
        "${path_input}"
    else
        "${program}" "${path_input}"
    fi
    printf "${LBLUE}[run]${NC}:${YELLOW} Done.\n"
}

function compile_run {
    local path_input=
    local path_output=
    printf "${LCYAN}[compile_run]${NC}:${YELLOW} Compiling.\n"
    compile "$@"
    printf "${LCYAN}[compile_run]${NC}:${YELLOW} Running ${LGREEN}${path_output} ${NC}${YELLOW}.\n"
    run "$path_output"
}


############### Aliases ###############

alias ahelp="alias_help" # List all available aliases

alias myip='curl "https://api.ipify.org"' # Get public ip adress

# Git
alias g='git' # Git
alias ga='git add' # Git add
alias gaa='git add --all' # Git add all unstaged changes
alias gr='git remove' # Git unstage/remove
alias gc='git commit' # Git commit
alias gl='git log' # Git log
alias gca='git commit --amend' # Git ammend
alias gp='git push' # Git push
alias gpl='git pull' # Git pull
alias gf='git fetch' # Git fetch
alias gst='git status' # Git status
alias grt='cd $(git rev-parse --show-toplevel)' # Jump to the root of the git repository
alias gsb='git switch $(git branch | sd "[ |*]" "" | $FUZZY_FINDER)' # Git interacitvely switch branche
alias grb='git branch -d $(git branch | sd "[ |*]" "" | $FUZZY_FINDER)' # Git interacitvely delete branche
function git_search_commits() { 
    git --no-pager log --pretty="%s|%cn|%cr|%h" | awk -F'|' '{ printf "%s... by %s, %s (%s)\n", $1=substr($1,1,25), $2, $3, $4 }' | sk | /usr/bin/sed -n -r 's/^.*\((\w+)\)$/\1/p'
}
alias gsc='git_search_commits' # Search git commits

# .. for moving up one directory in shells where that isn't supported
alias ..='cd ..'
# Always use sudo when running pacman
alias pacman='sudo pacman'

# Alias for opening files with emacsclient
alias emcs='emacsclient --tty' # Open emacs in terminal
alias emcS='devour emacsclient --create-frame' # Open emacs in GUI and hide the terminal window
alias emCS='emacsclient --create-frame' # Open emacs in GUI

# Alias for copying output of a command to clipboard
alias cpy='xclip -selection clipboard' # Copy piped command output to clipboard

# Aliases for hiding terminal when starting certain programs
alias zathura='devour zathura'
alias feh='devour feh'
alias mpv='devour mpv'

# Exa (ls replacement)
alias ls='exa --grid --icons'
alias ll='exa --long --icons'
alias la='exa --long --all'
alias l='exa --grid --across'
alias tree='exa --tree --icons'

# zoxide (cd replacement)
alias cd='z'

# skim (fzf replacement)
alias fzf='sk'

# RipGrep (grep replacement)
alias grep='rg --no-line-number'

# fd (find replacement)
alias find='fd'

# Procs (ps replacement)
alias ps='procs'

# Dust (du replacement)
alias du='dust'

# Bottom (top replacement)
alias top='btm'
alias htop='btm'

# Bat (cat replacement)
alias cat='bat --paging=never --theme=Dracula --style="numbers,changes" --italic-text=always'
alias ct='bat --paging=never --theme=Dracula --style="plain" --italic-text=always'


############### Boring Stuff ###############

# Clean up home dir by moving some dotfiles to the XDG directories they should be in by default
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch-config"
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc-2.0"
export LESSHISTFILE="-"
export WGETRC="${XDG_CONFIG_HOME}/wget/wgetrc"
export INPUTRC="${XDG_CONFIG_HOME}/shell/inputrc"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
export WINEPREFIX="${XDG_DATA_HOME}/wineprefixes/default"
export KODI_DATA="${XDG_DATA_HOME}/kodi"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export ANDROID_SDK_HOME="${XDG_CONFIG_HOME}/android"
export CARGO_HOME="${XDG_DATA_HOME}/cargo"
export GOPATH="${XDG_DATA_HOME}/go"
export ANSIBLE_CONFIG="${XDG_CONFIG_HOME}/ansible/ansible.cfg"
export UNISON="${XDG_DATA_HOME}/unison"
export HISTFILE="${XDG_DATA_HOME}/history"
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"
export VSCODE_PORTABLE="$XDG_DATA_HOME/vscode"
export PYLINTHOME="$XDG_CACHE_HOME/pylint"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NVM_DIR="$XDG_DATA_HOME/nvm"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"

# Path variable
export PATH="$PATH:$CARGO_HOME/bin"
export PATH="$PATH:$GEM_HOME/ruby/2.7.0/bin/"
export PATH="$PATH:$HOME/.rvm/bin"


# Enable colored output wherever that isn't the default
# alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
# alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# alias ll='ls -alF'
# alias la='ls -A'
# alias l='ls -CF'
