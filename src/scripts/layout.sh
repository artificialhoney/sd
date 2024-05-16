#!/bin/bash

OUTPUT="sd/output/$SD_STYLE/$SD_PROJECT"

SIZE=4

TYPES=('bitter' 'ginger' 'joy')

for TYPE in "${TYPES[@]}"; do
    rm -rf "$OUTPUT/$TYPE/instagram"
    rm -rf "$OUTPUT/$TYPE/tiktok"
    mkdir -p "$OUTPUT/$TYPE/instagram"
    mkdir -p "$OUTPUT/$TYPE/tiktok"

    COUNT=0

    if [ "$TYPE" == "ginger" ]; then
        BLOCK=8
    else
        BLOCK=4
    fi

    for f in $OUTPUT/$TYPE/$TYPE-*; do
        if [ $COUNT -lt $((SIZE * BLOCK)) ]; then
            cp "$f" "$OUTPUT/$TYPE/instagram"
            COUNT=$((COUNT + 1))
        elif [ $((COUNT)) -lt $((2 * SIZE * BLOCK)) ]; then
            cp "$f" "$OUTPUT/$TYPE/tiktok"
            COUNT=$((COUNT + 1))
        else
            break
        fi
    done
done
