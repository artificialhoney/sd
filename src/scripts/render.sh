#!/bin/bash

STYLED=giger/examples/styled/styled.py

FACE="$SD_ASSETS/faces/palina/dirne.png"

# Initialize our own variables:
SETTING="$SD_SETTING"
MUSE="$SD_MUSE"
OBJECT="$SD_OBJECT"
SIZE=10
COUNT=4

# More safety, by turning some bugs into errors.
set -o errexit -o pipefail -o noclobber -o nounset

# ignore errexit with `&& true`
getopt --test > /dev/null && true
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
        -x|--setting)
            SETTING="$2"
            shift 2
            ;;
        -m|--muse)
            MUSE="$2"
            shift 2
            ;;
        -o|--object)
            OBJECT="$2"
            shift 2
            ;;
        -s|--size)
            SIZE=$2
            shift 2
            ;;
        -c|--count)
            COUNT=$2
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

MODS=()
while [ $OPTIND -le "$#" ]
do
    MODS+=("--mod ${!OPTIND}")
    ((OPTIND++))
done

_MODS=($SD_MODS)
for value in "${_MODS[@]}"
do
  MODS+=("--mod ${value}")
done


# Prepare
rm -rf "$SD_OUTPUT/*"

DIMENSION=${SD_RESOLUTION:-"(960, 560)"}

# bitter
TYPE="bitter"
DIMENSION=${SD_RESOLUTION_BITTER:-"$DIMENSION"}
$STYLED "$SD_STYLE" -o "$SD_OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$SETTING" --bypass_safety ${MODS[@]}

# ginger
TYPE="ginger"
DIMENSION=${SD_RESOLUTION_GINGER:-"$DIMENSION"}
$STYLED "$SD_STYLE" -o "$SD_OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$MUSE" --mod "$SETTING" -f "$FACE" --bypass_safety ${MODS[@]}

# joy
TYPE="joy"
DIMENSION=${SD_RESOLUTION_JOY:-"$DIMENSION"}
$STYLED "$SD_STYLE" -o "$SD_OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$OBJECT" --mod "$SETTING" --bypass_safety ${MODS[@]}