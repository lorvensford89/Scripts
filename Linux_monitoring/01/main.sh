#!/bin/bash

: '
Write a bash script. The script is run with one parameter. It is a text parameter.
The script outputs the value of the parameter.
If the parameter is a number, the script must output an invalid input message.'

if [[ $# -ne 1 ]]; then
    echo "ERROR: One parameter is required for running this script."
    exit 1
else
    if [[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]; then
        echo "ERROR: Parameter should not be a number."
        exit 1
    else
        echo "$1"
    fi
fi
