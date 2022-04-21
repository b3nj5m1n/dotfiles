source /usr/bin/scripts/colors.sh

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
            pandoc --standalone --from "$format_input" --to "$format_output" --output "$path_output" "$path_input" --citeproc
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

compile $@
