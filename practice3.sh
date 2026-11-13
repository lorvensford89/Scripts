#!/bin/bash
# This is a little practice about getting input and check it at the same time.

FIRSTNAME="Junior"
LASTNAME="EL"
AGE=27
OCCUPATION="Software Engineering Student"

lines() {
    for ((i = 0; i < $1; i++)); do
        echo -e "\n"
        done
}

personal_info() {
    lines 1
    echo "Name: $FIRSTNAME $LASTNAME"
    echo "Age : $AGE"
    echo "Occupation : $OCCUPATION"
    lines 1
}

personal_info