#!/bin/bash
: 'Write a bash script. The script is run with a single parameter.
The parameter is an absolute or relative path to a directory. 
The parameter must end with '/', for example:
script05.sh /var/log/

The script must output the following information about the directory specified in the parameter:

    - Total number of folders, including subfolders
    - Top 5 folders with largest size in descending order (path and size)
    - Total number of files
    - Number of configuration files (with .conf extension), text files, executable files, 
      log files (files with .log extension), archives, symbolic links
    - Top 10 files with largest size in descending order (path, size and type)
    - Top 10 executable files with largest size in descending order (path, size and hash)
    - Execution time of the script'

# A line function
lines() {
    for ((i = 0; i < $1; i++)); do
        echo -e "\n"
    done
}

# Checking if one parameter was input
if [[ "$#" -ne 1 ]]; then
    echo "ERROR: The script needs only ONE(1) parameter to run."
    lines 1
    echo "Exiting..."
    exit 1
fi

# Checking that the parameter ends with /
if [[ "$1" != */ ]]; then
    echo "ERROR: The parameter must end with '/', for example:"
    echo "script05.sh /var/log/"
    lines 1
    echo "Exiting..."
    exit 1
fi

# Checking if the directory exists
if [[ ! -d "$1" ]]; then 
    echo "ERROR: Directory \"$1\" does not exist."
    lines 1
    echo "Exiting..."
    exit
fi



echo "The parameter you wrote: $1"


