#!/usr/bin/env bash

IFS=':' read -ra TYPES <<< "$SD_TYPES"

GLOBALSOCIALS=${SD_SOCIALS:-""}
SOCIALSCOUNT=${SD_SOCIALSCOUNT:-3}

for TYPE in "${TYPES[@]}"; do
    T=$(echo $TYPE | tr a-z A-Z)    
    declare -n SW="SD_SWAP_$T"
    _SWAP=${SW:-$SWAP}

    if [ $_SWAP -gt 0 ]; then
        GLOB="*.swapped.png.upscaled.png"
    else
        GLOB="*.upscaled.png"
    fi

    declare -n SW="SD_SWAP_$T"
    _SWAP=${SW:-$SWAP}

    declare -n C="SD_SOCIALSCOUNT_${T}"
    _SOCIALSCOUNT=${C:-$SOCIALSCOUNT}

    declare -n S="SD_SOCIALS_${T}"
    _SOCIALS=${S:-$GLOBALSOCIALS}

    IFS=':' read -ra SOCIALS <<<"$_SOCIALS"

    for SOCIAL in ${SOCIALS[@]}; do
        rm -rf "$SD_OUTPUT/$TYPE/$SOCIAL/*"
        mkdir -p "$SD_OUTPUT/$TYPE/$SOCIAL"

        ls $SD_OUTPUT/$TYPE/$GLOB | sort -R | tail -$((_SOCIALSCOUNT + 1)) | while read f; do
            cp $f $SD_OUTPUT/$TYPE/$SOCIAL
        done
    done
done
