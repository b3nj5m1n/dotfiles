# This doesn't work as of now, because the function 
# expects $path_output to be set by the compile function, 
# which doesn't happen because they're seperate scripts now

# source /usr/bin/scripts/colors.sh

# function compile_run {
#     local path_input=
#     local path_output=
#     printf "${LCYAN}[compile_run]${NC}:${YELLOW} Compiling.\n"
#     compile "$@"
#     printf "${LCYAN}[compile_run]${NC}:${YELLOW} Running ${LGREEN}${path_output} ${NC}${YELLOW}.\n"
#     run "$path_output"
# }

# compile_run $@
