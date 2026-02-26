#!/bin/bash

# 1. Set the limit
THRESHOLD=80

# 2. Get the current usage of the root partition "/"
# df -h = disk free (human readable)
# grep /$ = looks for the line ending in slash (the root)
# awk = prints the 5th column (the percentage)
# tr -d '%' = deletes the percentage sign so we just have a number
USAGE=$(df -h | grep /$ | awk '{print $5}' | tr -d '%')

# 3. Compare and Report
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "[CRITICAL] Disk space is low! Used: ${USAGE}%"
    exit 1 
else
    echo "[OK] Disk space is healthy. Used: ${USAGE}%"
fi