#!/bin/bash

# Number checking: returns 0(success) if the text is a number
is_number() {
    [[ "$1" =~ ^-?[0-9]+(\.[0-9]+)?$ ]]
}
