#!/usr/bin/env bash

STYLED=giger/examples/styled/styled.py

FACE="$SD_ASSETS/faces/palina/dirne.png"

# Initialize our own variables:
SIZE=10
COUNT=4

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

IFS=':' read -ra MODS <<<"$SD_MODS"
MODDING=""
for MOD in "${MODS[@]}"; do
    MODDING="$MODDING --mod \"${MOD}\""
done

while [ $OPTIND -le "$#" ]; do
    MODDING="$MODDING --mod \"${!OPTIND}\""
    ((OPTIND++))
done

# Prepare
rm -rf "$SD_OUTPUT/*"

IFS=':' read -ra TYPES <<<"$SD_TYPES"

DIMENSION=${SD_RESOLUTION:-"(960, 560)"}
OBJECT=${SD_OBJECT-""}
PROMPT=${SD_PROMPT:-"modprompt_so"}
SETTING=${SD_SETTING:-""}
SWAP=${SD_SWAP:- -1}

for TYPE in "${TYPES[@]}"; do
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

    CONTEXT="$(bash $SD_SCRIPTS/prompts/$_PROMPT.sh "$_OBJECT" "$_SETTING")"

    if [ $_SWAP -gt 0 ]; then
        CONTEXT="$CONTEXT -f $FACE"
    fi

    eval $STYLED -o "$SD_OUTPUT" -b "$TYPE" -s "$RANDOM" -d "'$_DIMENSION'" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --bypass_safety $MODDING $CONTEXT "$SD_STYLE"
done
