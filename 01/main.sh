#!/bin/bash

source "$(dirname "$0")/check.sh"

if [[ $# -ne 1 ]]; then
    echo "ERROR: One parameter is required for running this script."
    exit 1
fi

if is_number "$1"; then
    echo "ERROR: Parameter should not be a number."
    exit 1
fi

echo "$1"
