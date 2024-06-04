#!/usr/bin/env bash

# More safety, by turning some bugs into errors.
set -o errexit -o pipefail -o noclobber -o nounset

# ignore errexit with `&& true`
getopt --test >/dev/null && true
if [[ $? -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

LONGOPTS=setting:,muse:,object:,size:,count:
OPTIONS=x:m:o:s:c:

# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
# -if getopt fails, it complains itself to stdout
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
    -x | --setting)
        SETTING="$2"
        shift 2
        ;;
    -m | --muse)
        MUSE="$2"
        shift 2
        ;;
    -o | --object)
        OBJECT="$2"
        shift 2
        ;;
    -s | --size)
        SIZE="$2"
        shift 2
        ;;
    -c | --count)
        COUNT="$2"
        shift 2
        ;;
    --)
        shift
        break
        ;;
    *)
        echo "Programming error"
        exit 3
        ;;
    esac
done

# Prepare
rm -rf "$SD_OUTPUT/*"

GLOBALMODS=""
while [ $OPTIND -le "$#" ]; do
    GLOBALMODS="$GLOBALMODS --mod \"${!OPTIND}\""
    ((OPTIND++))
done

IFS=':' read -ra _TYPES <<<"$TYPES"

for TYPE in "${_TYPES[@]}"; do
    T=$(echo $TYPE | tr a-z A-Z)

    declare -n M="SD_MODS_${T}"
    _MODS=${M:-$MODS}
    IFS=':' read -ra __MODS <<<"$_MODS"
    MODDING="$GLOBALMODS"
    for MOD in "${__MODS[@]}"; do
        MODDING="$MODDING --mod \"${MOD}\""
    done

    declare -n M="SD_MODEL_${T}"
    _MODEL=${M:-$MODEL}
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
    declare -n EF="SD_ENHANCE_FACE_${T}"
    _ENHANCE_FACE=${EF:-$ENHANCE_FACE}

    CONTEXT="$(bash $SD_SCRIPTS/prompts/$_PROMPT.sh "$_OBJECT" "$_SETTING")"

    if [ $_SWAP -gt 0 ]; then
        CONTEXT="$CONTEXT -f $FACE"
    fi

    if [ $_ENHANCE_FACE -gt 0 ]; then
        CONTEXT="$CONTEXT -ef"
    fi

    eval $STYLED -o "$SD_OUTPUT" -b "$TYPE" -s "$RANDOM" -d "'$_DIMENSION'" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 -m "$_MODEL" --bypass_safety $MODDING $CONTEXT "$SD_STYLE"
done
