#!/bin/bash

source "$(dirname "$0")/info.sh"

# Message: if "ipcalc" is not installed
if ! command -v ipcalc > /dev/null; then
    echo "ERROR: ipcalc is not installed. Run: sudo apt install ipcalc"
    exit 1
fi

if [[ $# -ne 0 ]]; then
    echo "ERROR: The script runs without parameters."
    exit 1
fi

OUTPUT=$(print_information)
echo "$OUTPUT"

echo
read -p "Write the data into a file? (Y/N): " answer
if [[ "$answer" =~ ^[Yy]$ ]]; then
    file_name="$(date +"%d_%m_%y_%H_%M_%S").status"
    echo "$OUTPUT" > "$file_name"
fi