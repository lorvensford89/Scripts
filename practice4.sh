#!/bin/bash

echo "$(du -h | sort -rh | head -5 | awk '{print NR " - " $2 ", " $1}')"
