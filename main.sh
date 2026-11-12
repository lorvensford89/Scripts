#!/bin/bash
# Checking if a variable is a number

number="45"
if [[ "$number" =~ ^[0-9]+$ ]]
then
echo "$number is a number"
else
echo "$number is not a number"
fi
