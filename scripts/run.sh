source ~/dotfiles/scripts/colors.sh

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

run $@
