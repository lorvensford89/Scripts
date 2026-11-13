#!/bin/bash
# This is a little practice about getting input and check it at the same time.

FIRSTNAME="Junior"
LASTNAME="EL"
AGE=27
OCCUPATION="Software Engineering Student"

lines() {
    for ((i = 0; i < $1; i++)); do
        echo -e "\n"
        done
}

# Background colors
BG_WHITE="\033[47m"
BG_RED="\033[41m"
BG_GREEN="\033[42m"
BG_BLUE="\033[44m"
BG_PURPLE="\033[45m"
BG_BLACK="\033[40m"

# Font colors
FG_WHITE="\033[37m"
FG_RED="\033[31m"
FG_GREEN="\033[32m"
FG_BLUE="\033[34m"
FG_PURPLE="\033[35m"
FG_BLACK="\033[30m"

RESET="\033[0m"

echo -e "${BG_RED}Doing goood!${RESET}"
echo -e "${BG_WHITE}The color white!${RESET}"

personal_info() {
    lines 1
    echo "Name: $FIRSTNAME $LASTNAME"
    echo "Age : $AGE"
    echo "Occupation : $OCCUPATION"
    lines 1
}


personal_info


# The script is run with 4 parameters. The parameters are numeric, from 1 to 6.
if [[ "$#" -ne 4 ]]; then
    echo "ERROR: There should be four(4) arguments."
    exit 1
else
    for parameter in "$@"; do
        if ! [[ "$parameter" =~ ^[1-6]$ ]]; then
            echo "The value of the arguments should be between 1 and 6 inclusively."
            exit 1
        fi
    done
fi


