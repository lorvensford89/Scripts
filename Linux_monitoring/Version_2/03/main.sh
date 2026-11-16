#!/bin/bash

source "$(dirname "$0")/colors.sh"
source "$(dirname "$0")/info.sh"

# Message: if "ipcalc" is not installed
if ! command -v ipcalc > /dev/null; then
    echo "ERROR: ipcalc is not installed. Run: sudo apt install ipcalc"
    exit 1
fi

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

# The font and background colours of one column must not match.
if [ "$1" -eq "$2" ] || [ "$3" -eq "$4" ]; then
    echo "ERROR: The font and background colours of one column must not match."
    echo "Run the script again. Example: $0 1 2 4 6"
    exit 1
fi


# Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)
# Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)
# Parameter 3 is the background of the values (after the '=' sign)
# Parameter 4 is the font colour of the values (after the '=' sign)
NAME_BG=$(get_background "$1")    
NAME_FG=$(get_font "$2")    
VALUE_BG=$(get_background "$3")   
VALUE_FG=$(get_font "$4")  

print_information