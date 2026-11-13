#!/bin/bash

: '  Write a bash script. Use the script from Part 2 and remove the 
part where the data is saved to a file. The script is run with 4 
parameters. The parameters are numeric. From 1 to 6, for example:
script03.sh 1 3 4 5

Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)

Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)
Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)
Parameter 3 is the background of the values (after the '=' sign)
Parameter 4 is the font colour of the values (after the '=' sign)

The font and background colours of one column must not match.
If matching values are entered, there must be a message describing the problem 
and offering to call the script again. After the message output, the program 
should exit correctly.
'

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

# Colour designations: (1 - white, 2 - red, 3 - green, 4 - blue, 5 - purple, 6 - black)

RESET="\033[0m"


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


print_information() {
    # System's ID
    echo -e "${NAME_BG}${NAME_FG}HOSTNAME${RESET} = ${VALUE_BG}${VALUE_FG}$(hostname)${RESET}"
    echo -e "${NAME_BG}${NAME_FG}TIMEZONE${RESET} = ${VALUE_BG}${VALUE_FG}$(timedatectl show -p Timezone --value) UTC $(date +%:::z | sed 's/0\([0-9]\)/\1/')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}USER${RESET} = ${VALUE_BG}${VALUE_FG}$(whoami)${RESET}"
    source /etc/os-release
    echo -e "${NAME_BG}${NAME_FG}OS${RESET} = ${VALUE_BG}${VALUE_FG}${PRETTY_NAME}${RESET}"
    echo -e "${NAME_BG}${NAME_FG}DATE${RESET} = ${VALUE_BG}${VALUE_FG}$(date +"%d %B %Y %T")${RESET}"
    echo -e "${NAME_BG}${NAME_FG}UPTIME${RESET} = ${VALUE_BG}${VALUE_FG}$(uptime -p | sed 's/up //' | sed 's/,//g')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}UPTIME_SEC${RESET} = ${VALUE_BG}${VALUE_FG}$(awk '{print int($1)}' /proc/uptime)${RESET}"

    # Network information
    IP_CIDR=$(ip -br a | awk '$1 != "lo" && $2 == "UP" {print $3; exit}')
    IP_ADDRESS=$(echo "$IP_CIDR" | cut -d/ -f1)
    echo -e "${NAME_BG}${NAME_FG}IP${RESET} = ${VALUE_BG}${VALUE_FG}${IP_ADDRESS}${RESET}"
    echo -e "${NAME_BG}${NAME_FG}MASK${RESET} = ${VALUE_BG}${VALUE_FG}$(ipcalc "$IP_CIDR" | awk '/Netmask/ {print $2}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}GATEWAY${RESET} = ${VALUE_BG}${VALUE_FG}$(ip route | grep "default via" | awk '{print $3}')${RESET}"

    # RAM storage information
    echo -e "${NAME_BG}${NAME_FG}RAM_TOTAL${RESET} = ${VALUE_BG}${VALUE_FG}$(free | awk '/Mem:/ {printf "%.3f GB", $2/1024/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}RAM_USED${RESET} = ${VALUE_BG}${VALUE_FG}$(free | awk '/Mem:/ {printf "%.3f GB", $3/1024/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}RAM_FREE${RESET} = ${VALUE_BG}${VALUE_FG}$(free | awk '/Mem:/ {printf "%.3f GB", $4/1024/1024}')${RESET}"

    # Root storage information
    echo -e "${NAME_BG}${NAME_FG}SPACE_ROOT${RESET} = ${VALUE_BG}${VALUE_FG}$(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}SPACE_ROOT_USED${RESET} = ${VALUE_BG}${VALUE_FG}$(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}SPACE_ROOT_FREE${RESET} = ${VALUE_BG}${VALUE_FG}$(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')${RESET}"
}


print_information