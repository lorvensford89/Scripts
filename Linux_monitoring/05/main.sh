#!/bin/bash
START_TIME=$(date +%s.%N)

: 'Write a bash script. The script is run with a single parameter.
The parameter is an absolute or relative path to a directory. 
The parameter must end with '/', for example: script05.sh /var/log/ 

The script must output the following information about the directory specified in the parameter:

    - Total number of folders, including subfolders
    - Top 5 folders with largest size in descending order (path and size)
    - Total number of files
    - Number of configuration files (with .conf extension), text files, executable files, 
      log files (files with .log extension), archives, symbolic links
    - Top 10 files with largest size in descending order (path, size and type)
    - Top 10 executable files with largest size in descending order (path, size and hash)
    - Execution time of the script'


# Important feedback on the example of the parameter: The path should start from the root ("/") it seems.
# Modification to make in the parameter validation block.


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


# For checking -> remove after
echo "The parameter you wrote: $1"
lines 1
echo "Its content:"
echo "$(ls $1)"
lines 1


# System file information

ALLDIRS=$(find "$1" -type d | wc -l)
echo "Total number of folders (including all nested ones) = $ALLDIRS" 

DIRSIZE=$(du -h | sort -rh | head -5)
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
du -b "$1" 2>/dev/null | sort -rn | awk -F'\t' -v root="$1" '$2 != root' | head -5 | awk -F'\t' '{
    size = $1
    split("B KB MB GB", unit, " ")
    i = 1
    while (size >= 1024 && i < 4) { size = size / 1024; i++ }
    printf "%d - %s/, %.2f %s\n", NR, $2, size, unit[i]
}'

echo "Total number of files = $(find "$1" -type f | wc -l)"

echo "Number of: "
echo "Configuration files (with the .conf extension) = $(find "$1" -type f -name "*.conf" | wc -l)"
echo "Text files = $(find "$1" -type f -name "*.txt" | wc -l)"
echo "Executable files = $(find "$1" -type f -executable | wc -l)"
echo "Log files (with the extension .log) = $(find "$1" -type f -name "*.log" | wc -l)"
echo "Archive files = $(find "$1" -type f \( \
    -name "*.tar" -o \
    -name "*.tar.gz" -o \
    -name "*.tgz" -o \
    -name "*.tar.bz2" -o \
    -name "*.tar.xz" -o \
    -name "*.zip" -o \
    -name "*.7z" -o \
    -name "*.rar" \
\) | wc -l)"
echo "Symbolic links = $(find "$1" -type l | wc -l)"


echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
find "$1" -type f -exec du -b {} + 2>/dev/null | sort -rn | head -10 | awk -F'\t' '{
    SIZE = $1
    PATH = $2

    # size: divide by 1024 until the number is small
    split("B KB MB GB", unit, " ")
    i = 1
    while (SIZE >= 1024 && i < 4) { 
        SIZE = SIZE / 1024; 
        i++ 
    }

    # type: the text after the last dot in the file name
    n = split(PATH, parts, "/")
    TYPEFILE = parts[n]
    if (index(TYPEFILE, ".") > 1) 
        sub(/.*\./, "", TYPEFILE); 
    else 
        TYPEFILE = "-"

    printf "%d - %s, %.2f %s, %s\n", NR, PATH, SIZE, unit[i], TYPEFILE
}'


echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
find "$1" -type f -executable -exec du -b {} + 2>/dev/null | sort -rn | head -10 | awk -F'\t' '{
    SIZE2 = $1
    PATH2 = $2

    # size: divide by 1024 until the number is small
    split("B KB MB GB", unit, " ")
    i = 1
    while (SIZE2 >= 1024 && i < 4) { SIZE2 = SIZE2 / 1024; i++ }

    # hash: run md5sum from inside awk
    COMMAND = "md5sum \"" PATH2 "\""
    COMMAND | getline line
    close(COMMAND)
    split(line, h, " ")

    printf "%d - %s, %.2f %s, %s\n", NR, PATH2, SIZE2, unit[i], h[1]
}'

# Exection time
END_TIME=$(date +%s.%N)
TOTAL_TIME=$(echo "$END_TIME - $START_TIME" | bc)
printf "Script execution time (in seconds) = %.9f\n" "$TOTAL_TIME"