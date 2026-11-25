#!/bin/bash
# Project 4: Linux monitoring using Prometheus and Grafana

echo "I am about to start"

if [ "$#" -ne 6 ]; then
    echo "ERROR: 6 parameters required."
    exit 1
fi
