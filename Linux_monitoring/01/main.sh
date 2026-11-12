#!/bin/bash

: '
Напиши bash-скрипт. Скрипт запускается с одним параметром. 
Параметр текстовый.
Скрипт выводит значение параметра.
Если параметр — число, то должно выводиться сообщение о некорректности ввода.'

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
