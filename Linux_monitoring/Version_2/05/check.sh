#!/bin/bash

# Exiting message
error_exit() {
    echo "ERROR: $1"
    echo
    echo "Exiting..."
    exit 1
}

# Input validations
check_parameters() {
    # The script is run with a single parameter.
    if [[ "$#" -ne 1 ]]; then
        error_exit "The script needs ONE(1) parameter to run."
    fi

    # The parameter must end with "/".
    if [[ "$1" != */ ]]; then
        error_exit "The parameter must end with '/'"
    fi

    # The parameter is an absolute or relative path to a directory.
#     if [[ ! -d "$1" ]]; then
#         error_exit "Directory \"$1\" does not exist."
#     fi
# }