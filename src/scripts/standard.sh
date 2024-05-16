#!/bin/bash

STYLED=giger/examples/styled/styled.py

STYLE=${STYLE:-"demonic"}
PROJECT=${PROJECT:-"xx"}
OUTPUT="sd/output/$STYLE/$PROJECT"
FACE="sd/assets/faces/palina/dirne.png"

DIMENSION="(960, 560)"

# Initialize our own variables:
SETTING=""
MUSE=""
OBJECT=""
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


# Prepare
rm -rf "$OUTPUT"

# ginger
TYPE="ginger"
$STYLED "$STYLE" -o "$OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$MUSE" --mod "$SETTING" -f "$FACE" --bypass_safety ${MODS[@]}

# bitter
TYPE="bitter"
$STYLED "$STYLE" -o "$OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$SETTING" --bypass_safety ${MODS[@]}

# bitter
TYPE="joy"
$STYLED "$STYLE" -o "$OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$OBJECT" --mod "$SETTING" --bypass_safety ${MODS[@]}

# Cleanup
find $OUTPUT -type f -name '*.png' -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -progress "{}" -o "{}.webp"
