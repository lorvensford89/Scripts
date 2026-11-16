#!/bin/bash

# The script is run with a single parameter.
# The parameter is an absolute or relative path to a directory.
# The parameter must end with "/", for example: main.sh /var/log/

START_TIME=$(date +%s.%N)

SCRIPT_DIR="$(dirname "$0")"

# Functions from check.sh and info.sh
source "$SCRIPT_DIR/check.sh"
source "$SCRIPT_DIR/info.sh"

# Parameter validation
check_parameters "$@"

# Output the information about the directory
print_information "$1"

# Execution time
END_TIME=$(date +%s.%N)
awk -v s="$START_TIME" -v e="$END_TIME" 'BEGIN { printf "Script execution time (in seconds) = %.1f\n", e - s }'
