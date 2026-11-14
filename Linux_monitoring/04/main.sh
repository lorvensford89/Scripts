#!/bin/bash
: 'Write a bash script. Use the script from Part 3. 
The colour designations are similar. The script runs
without parameters. The parameters are set in the 
configuration file before the script is running.'



# Make the variables in configuration.conf file usable
source "$(dirname "$0")/configuration.conf"

# Default messages
column1_background_stick=${column1_background:-default}
column1_font_color_stick=${column1_font_color:-default}
column2_background_stick=${column2_background:-default}
column2_font_color_stick=${column2_font_color:-default}

# Default values
column1_background=${column1_background:-5}     # 5- purple
column1_font_color=${column1_font_color:-2}     # 2- red
column2_background=${column2_background:-3}     # 3- green
column2_font_color=${column2_font_color:-1}     # 1- white


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

RESET="\033[0m"

# Parameter validation
# for number in "$column1_background" "$column1_font_color" "$column2_background" "$column2_font_color"; do
#     if [[ ! "$number" =~ ^[1-6]$ ]]; then
#         echo "ERROR: colour values must be numbers from 1 to 6."
#         echo "Modify the configuration file and run the script again."
#         exit 1
#     fi
# done

# The font and background colours of one column must not match.
if [ "$column1_background" -eq "$column1_font_color" ] || [ "$column2_background" -eq "$column2_font_color" ]; then
    echo "ERROR: The font and background colours of one column must not match."
    echo "Modify the configuration file and run the script again."
    exit 1
fi

# Parameter 1 is the background of the value names (HOSTNAME, TIMEZONE, USER etc.)
# Parameter 2 is the font colour of the value names (HOSTNAME, TIMEZONE, USER etc.)
# Parameter 3 is the background of the values (after the '=' sign)
# Parameter 4 is the font colour of the values (after the '=' sign)
NAME_BG=$(get_background "$column1_background")    
NAME_FG=$(get_font "$column1_font_color")    
VALUE_BG=$(get_background "$column2_background")   
VALUE_FG=$(get_font "$column2_font_color")  


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


# Color scheme
color_scheme() {
    case "$1" in
        1) echo "white" ;;
        2) echo "red" ;;
        3) echo "green" ;;
        4) echo "blue" ;;
        5) echo "purple" ;;
        6) echo "black" ;;
    esac
}

echo 
echo "Column 1 background = $column1_background_stick ($(color_scheme "$column1_background"))"
echo "Column 1 font color = $column1_font_color_stick ($(color_scheme "$column1_font_color"))"
echo "Column 2 background = $column2_background_stick ($(color_scheme "$column2_background"))"
echo "Column 2 font color = $column2_font_color_stick ($(color_scheme "$column2_font_color"))"