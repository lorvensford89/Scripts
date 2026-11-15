#!/bin/bash

: 'Write a bash script. The script should output the following information:

HOSTNAME = network name
TIMEZONE = time zone as: America/New_York UTC -5 (time zone must be taken from the system and be correct for the current location)
USER = current user who ran the script
OS = type and version of operating system
DATE = current time as: 12 May 2020 12:24:36
UPTIME = system uptime
UPTIME_SEC = system uptime in seconds
IP = _ip address of the machine on any of the network interfaces
MASK = network mask of any of the network interfaces as: xxx.xxx.xxx.xxx.
GATEWAY = default gateway ip
RAM_TOTAL = main memory size in GB with an accuracy of three decimal places as: 3.125 GB
RAM_USED = used memory size in GB with an accuracy of three decimal places
RAM_FREE = free memory size in GB, with an accuracy of three decimal places
SPACE_ROOT = root partition size in MB, with an accuracy of two decimal places, as 254.25 MB
SPACE_ROOT_USED = size of used space of the root partition in MB, with an accuracy of two decimal places
SPACE_ROOT_FREE = size of free space of the root partition in MB, with an accuracy of two decimal places

After outputting the values, suggest writing the data to a file (ask the user to answer Y/N).
Responses Y and y are considered positive, all others - negative.

If the user agrees, create a file in the current directory containing the information that had been outputted. The file name must looks like: DD_MM_YY_HH_MM_SS.status (The time in the file name must indicate when the data was saved).'


print_information() {
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
}

OUTPUT=$(print_information)
echo "$OUTPUT"

echo
read -p "Write the data into a file? (Y/N): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    file_name="$(date +"%d_%m_%y_%H_%M_%S").status"
    echo "$OUTPUT" > "$file_name"
fi