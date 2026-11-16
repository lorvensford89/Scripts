#!/bin/bash

# Information
print_information() {
    local DIR="$1"

    echo "Total number of folders (including all nested ones) = $(find "$DIR" -type d 2>/dev/null | wc -l)"

    echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
    du -b "$DIR" 2>/dev/null | sort -rn | awk -F'\t' -v root="$DIR" '$2 != root' | head -5 | awk -F'\t' '{
        size = $1

        # size: divide by 1024 until the number is small
        split("B KB MB GB", unit, " ")
        i = 1
        while (size >= 1024 && i < 4) { size = size / 1024; i++ }

        printf "%d - %s/, %.2f %s\n", NR, $2, size, unit[i]
    }'

    echo "Total number of files = $(find "$DIR" -type f 2>/dev/null | wc -l)"

    echo "Number of:"
    echo "Configuration files (with the .conf extension) = $(find "$DIR" -type f -name "*.conf" 2>/dev/null | wc -l)"
    echo "Text files = $(find "$DIR" -type f -name "*.txt" 2>/dev/null | wc -l)"
    echo "Executable files = $(find "$DIR" -type f -executable 2>/dev/null | wc -l)"
    echo "Log files (with the extension .log) = $(find "$DIR" -type f -name "*.log" 2>/dev/null | wc -l)"
    echo "Archive files = $(find "$DIR" -type f \( \
        -name "*.tar" -o \
        -name "*.tar.gz" -o \
        -name "*.tgz" -o \
        -name "*.tar.bz2" -o \
        -name "*.tar.xz" -o \
        -name "*.zip" -o \
        -name "*.7z" -o \
        -name "*.rar" \
    \) 2>/dev/null | wc -l)"
    echo "Symbolic links = $(find "$DIR" -type l 2>/dev/null | wc -l)"

    echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
    find "$DIR" -type f -exec du -b {} + 2>/dev/null | sort -rn | head -10 | awk -F'\t' '{
        size = $1
        path = $2

        # size: divide by 1024 until the number is small
        split("B KB MB GB", unit, " ")
        i = 1
        while (size >= 1024 && i < 4) { size = size / 1024; i++ }

        # type: the text after the last dot in the file name
        n = split(path, parts, "/")
        type = parts[n]
        if (index(type, ".") > 1)
            sub(/.*\./, "", type)
        else
            type = "-"

        printf "%d - %s, %.2f %s, %s\n", NR, path, size, unit[i], type
    }'

    echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"
    find "$DIR" -type f -executable -exec du -b {} + 2>/dev/null | sort -rn | head -10 | awk -F'\t' '{
        size = $1
        path = $2

        # size: divide by 1024 until the number is small
        split("B KB MB GB", unit, " ")
        i = 1
        while (size >= 1024 && i < 4) { size = size / 1024; i++ }

        # hash: run md5sum from inside awk
        line = ""
        command = "md5sum \"" path "\" 2>/dev/null"
        command | getline line
        close(command)
        split(line, hash, " ")

        printf "%d - %s, %.2f %s, %s\n", NR, path, size, unit[i], hash[1]
    }'
}