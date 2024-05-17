#!/bin/bash

SIZE=4

TYPES=('bitter' 'ginger' 'joy')

for TYPE in "${TYPES[@]}"; do
    rm -rf "$SD_OUTPUT/$TYPE/instagram/*"
    rm -rf "$SD_OUTPUT/$TYPE/tiktok/*"
    mkdir -p "$SD_OUTPUT/$TYPE/instagram"
    mkdir -p "$SD_OUTPUT/$TYPE/tiktok"

    COUNT=0

    if [ "$TYPE" == "ginger" ]; then
        BLOCK=8
    else
        BLOCK=4
    fi

    for f in $SD_OUTPUT/$TYPE/$TYPE-*; do
        if [ $COUNT -lt $((SIZE * BLOCK)) ]; then
            cp "$f" "$SD_OUTPUT/$TYPE/instagram"
            COUNT=$((COUNT + 1))
        elif [ $((COUNT)) -lt $((2 * SIZE * BLOCK)) ]; then
            cp "$f" "$SD_OUTPUT/$TYPE/tiktok"
            COUNT=$((COUNT + 1))
        else
            break
        fi
    done
done
