#/bin/bash

# Background colors
BG_WHITE="\033[47m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_BLUE="\033[44m"
BG_PURPLE="\033[45m"
BG_BLACK="\033[40m"

get_background() {
    case $1 in
        1) echo "$BG_WHITE" ;;
        2) echo "$BG_RED" ;;
        3) echo "$BG_GREEN" ;;
        4) echo "$BG_BLUE" ;;
        5) echo "$BG_PURPLE" ;;
        6) echo "$BG_BLACK" ;;
    esac
}

                                            # 1 - white
# Font colors                               # 2 - red
FG_WHITE="\033[37m"                         # 3 - green
FG_RED="\033[31m"                           # 4 - blue
FG_GREEN="\033[32m"                         # 5 - purple
FG_BLUE="\033[34m"                          # 6 - black
FG_PURPLE="\033[35m"
FG_BLACK="\033[30m"

get_font() {
    case $1 in
        1) echo "$FG_WHITE" ;;
        2) echo "$FG_RED" ;;
        3) echo "$FG_GREEN" ;;
        4) echo "$FG_BLUE" ;;
        5) echo "$FG_PURPLE" ;;
        6) echo "$FG_BLACK" ;;
    esac
}

# Resetting the terminal to its default color
RESET="\033[0m"