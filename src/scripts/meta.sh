#!/usr/bin/env bash

SD_META="$SD_OUTPUT/meta.yml"

mkdir -p $SD_OUTPUT

SD_TOP=4

DEFS=""

GLOBALMODS=""
while [ $OPTIND -le "$#" ]; do
    GLOBALMODS="$GLOBALMODS --mod \"${!OPTIND}\""
    ((OPTIND++))
done

IFS=':' read -ra _TYPES <<<"$TYPES"

for TYPE in "${_TYPES[@]}"; do
    declare -n M="SD_MODEL_${T}"
    _MODEL=${M:-$MODEL}
    T=$(echo $TYPE | tr a-z A-Z)
    declare -n D="SD_DIMENSION_${T}"
    _DIMENSION=${D:-$DIMENSION}
    declare -n O="SD_OBJECT_${T}"
    _OBJECT=${O:-"$OBJECT"}
    declare -n P="SD_PROMPT_${T}"
    _PROMPT=${P:-"$PROMPT"}
    declare -n S="SD_SETTING_${T}"
    _SETTING=${S:-"$SETTING"}
    declare -n SW="SD_SWAP_${T}"
    _SWAP=${SW:-$SWAP}

    declare -n M="SD_MODS_${T}"
    _MODS=${M:-$MODS}

    IMAGES=("$SD_OUTPUT"/$TYPE/*.png)

    read -r -d '' D <<-EOM
${DEFS}
${TYPE}:
    model: $_MODEL
    object: $_OBJECT
    setting: $_SETTING
    swap: $_SWAP
    dimension: $_DIMENSION
    mods: ${_MODS[*]}
    prompt: $_PROMPT
    styled: $(exiftool -ImageDescription "${IMAGES[0]}" | sed 's/^Image Description               : //')
EOM
DEFS="${D}"
done

cat >"$SD_META" <<-EOF
---
project: $SD_PROJECT_NAME
style: $SD_STYLE
$DEFS
EOF
