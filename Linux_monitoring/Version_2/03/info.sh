#!/bin/bash

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
    echo -e "${NAME_BG}${NAME_FG}GATEWAY${RESET} = ${VALUE_BG}${VALUE_FG}$(ip route | grep "default via" | awk '{print $3; exit}')${RESET}"

    # RAM storage information
    echo -e "${NAME_BG}${NAME_FG}RAM_TOTAL${RESET} = ${VALUE_BG}${VALUE_FG}$(free | awk '/Mem:/ {printf "%.3f GB", $2/1024/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}RAM_USED${RESET} = ${VALUE_BG}${VALUE_FG}$(free | awk '/Mem:/ {printf "%.3f GB", $3/1024/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}RAM_FREE${RESET} = ${VALUE_BG}${VALUE_FG}$(free | awk '/Mem:/ {printf "%.3f GB", $4/1024/1024}')${RESET}"

    # Root storage information
    echo -e "${NAME_BG}${NAME_FG}SPACE_ROOT${RESET} = ${VALUE_BG}${VALUE_FG}$(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}SPACE_ROOT_USED${RESET} = ${VALUE_BG}${VALUE_FG}$(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')${RESET}"
    echo -e "${NAME_BG}${NAME_FG}SPACE_ROOT_FREE${RESET} = ${VALUE_BG}${VALUE_FG}$(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')${RESET}"
}