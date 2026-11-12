#!/bin/bash
# Checking if a variable is a number

number=4.54
if [[ ! "$number" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
    echo "$number is not a number"
else
    echo "$number is a number"
fi
