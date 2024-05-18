#!/usr/bin/env bash

SIZE=${SD_SOCIALS_IMAGESCOUNT:-3}

IFS=':' read -ra TYPES <<< "$SD_TYPES"
IFS=':' read -ra SOCIALS <<< "$SD_SOCIALS"
SWAP=${SD_SWAP:-1}

for TYPE in "${TYPES[@]}"; do
    T=$(echo $TYPE | tr a-z A-Z)    
    declare -n SW="SD_SWAP_$T"
    SWAP=${SW:-$SWAP}

    for SOCIAL in ${SOCIALS[@]}; do
        rm -rf "$SD_OUTPUT/$TYPE/$SOCIAL/*"
        mkdir -p "$SD_OUTPUT/$TYPE/$SOCIAL"

        ls $SD_OUTPUT/$TYPE/$GLOB | sort -R | tail -$((SIZE + 1)) | while read f; do
            cp $f $SD_OUTPUT/$TYPE/$SOCIAL
        done
    done
done
