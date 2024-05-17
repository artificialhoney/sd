#!/bin/bash

SIZE=5

TYPES=('bitter' 'ginger' 'joy')

SOCIALS=('instagram' 'tiktok')

for TYPE in "${TYPES[@]}"; do
    if [ "$TYPE" == "ginger" ]; then
        GLOB="*.png.swapped.png.upscaled.png"
    else
        GLOB="*.png.upscaled.png"
    fi

    for SOCIAL in "${SOCIALS[@]}"; do
        rm -rf "$SD_OUTPUT/$TYPE/$SOCIAL/*"
        mkdir -p "$SD_OUTPUT/$TYPE/$SOCIAL"

        ls $SD_OUTPUT/$TYPE/$GLOB | sort -R | tail -$SIZE | while read f; do
            cp $f $SD_OUTPUT/$TYPE/$SOCIAL
        done
    done
done
