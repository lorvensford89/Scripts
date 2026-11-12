#!/bin/bash

# System's ID
echo "HOSTNAME = $(hostname)"
echo "TIMEZONE = $(timedatectl show -p Timezone --value) UTC $(date +%:::z | sed 's/0\([0-9]\)/\1/')"
echo "USER = $(whoami)"
source /etc/os-release
echo "OS = $PRETTY_NAME"
echo "DATE = $(date +"%d %B %Y %T")"
echo "UPTIME =$(uptime -p | sed 's/up//' | sed 's/,//g')"
echo "UPTIME_SEC = $(awk '{print int($1)}' /proc/uptime)"

# Network information
IP_CIDR=$(ip -br a | awk '$1 != "lo" && $2 == "UP" {print $3; exit}')
IP_ADDRESS=$(echo "$IP_CIDR" | cut -d/ -f1)
echo "IP = $IP_ADDRESS"
echo "MASK = $(ipcalc "$IP_CIDR" | awk '/Netmask/ {print $2}')"
echo "GATEWAY = $(ip route | grep "default via" | awk '{print $3}')"

# RAM storage information
echo "RAM_TOTAL = $(free | awk '/Mem:/ {printf "%.3f GB", $2/1024/1024}')"
echo "RAM_USED = $(free | awk '/Mem:/ {printf "%.3f GB", $3/1024/1024}')"
echo "RAM_FREE = $(free | awk '/Mem:/ {printf "%.3f GB", $4/1024/1024}')"

# Root storage information
echo "SPACE_ROOT = $(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')"
echo "SPACE_ROOT_USED = $(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')"
echo "SPACE_ROOT_FREE = $(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')"