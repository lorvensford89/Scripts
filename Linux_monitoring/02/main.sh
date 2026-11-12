#!/bin/bash

# System ID information
echo "HOSTNAME = $(hostname)"
echo "TIMEZONE = $(timedatectl | awk '/Time zone/ {print $3, $5}' | sed s'/)//')"
echo "USER = $(whoami)"
source /etc/os-release
echo "OS = $PRETTY_NAME"
echo "DATE = $(date +"%d %B %Y %T")"
echo "UPTIME =$(uptime -p | sed s'/up//' | sed s'/,//')"
echo "UPTIME_SEC = $(awk '{print $1}' /proc/uptime) seconds"


# Network information
# I have two ways for this(about the second, remember to make modifications)
#echo "IP = $(hostname -I | awk '{print $1})"
IP_ADDRESS=$(ip -br a | grep "eth0" | awk '{print $3}' | sed s'/\/20//') 
#echo "IP = $(ip -br a | grep "eth0" | awk '{print $3}' | sed s'/\/20//')"
echo "IP = $IP_ADDRESS"
echo "MASK = $(ipcalc $IP_ADDRESS | grep "Netmask" | awk '{print $2}')"
echo "GATEWAY = $(ip route | grep "default via" | awk '{print $3}')"


# RAM information
echo "RAM_TOTAL = $(free -m | awk '/Mem:/ {printf "%.3f GB", $2/1024}')"
echo "RAM_USED = $(free -m | awk '/Mem:/ {printf "%.3f GB", $3/1024}')"
echo "RAM_FREE = $(free -m | awk '/Mem:/ {printf "%.3f GB", $4/1024}')"


# Root storage information
echo "SPACE_ROOT = $(df / | awk 'NR==2 {printf "%.2f MB", $2/1024}')"
echo "SPACE_ROOT_USED = $(df / | awk 'NR==2 {printf "%.2f MB", $3/1024}')"
echo "SPACE_ROOT_FREE = $(df / | awk 'NR==2 {printf "%.2f MB", $4/1024}')"

