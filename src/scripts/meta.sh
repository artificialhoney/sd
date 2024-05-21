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
    T=$(echo $TYPE | tr a-z A-Z)
    declare -n D="SD_RESOLUTION_${T}"
    _DIMENSION=${D:-$DIMENSION}
    declare -n O="SD_OBJECT_${T}"
    _OBJECT=${O:-"$OBJECT"}
    declare -n P="SD_PROMPT_${T}"
    _PROMPT=${P:-"$PROMPT"}
    declare -n S="SD_SETTING_${T}"
    _SETTING=${S:-"$SETTING"}
    declare -n SW="SD_SWAP_${T}"
    _SWAP=${SW:-$SWAP}

    CONTEXT=$(bash $SD_SCRIPTS/prompts/$_PROMPT.sh "$_OBJECT" "$_SETTING")
    CONTEXT=${CONTEXT//--mod/}
    CONTEXT=${CONTEXT//--prompt/}

    declare -n M="SD_MODS_${T}"
    _MODS=${M:-$MODS}

    read -r -d '' D <<-EOM
${DEFS}
${TYPE}:
    object: $_OBJECT
    setting: $_SETTING
    swap: $_SWAP
    dimension: $_DIMENSION
    mods: ${_MODS[*]}
    prompt: $_PROMPT
    keywords: |
$(yake -ti "$CONTEXT" -t "$SD_TOP" | tail -4 | sed 's/^/        /')
EOM
DEFS="${D}"
done

cat >"$SD_META" <<-EOF
---
project: $SD_PROJECT_NAME
style: $SD_STYLE
$DEFS
EOF
