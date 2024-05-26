#!/usr/bin/env bash

export SD_SCRIPTS=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

set -a
. "$SD_SCRIPTS/../projects/$SD_PROJECT.env"
export SD_PROJECT_NAME="$SD_PROJECT"
set +a

export SD_OUTPUT="$SD_SCRIPTS/../../output/$SD_STYLE/$SD_PROJECT"
export SD_ASSETS="$SD_SCRIPTS/../../assets"

export STYLED=${SD_STYLED:-giger/examples/styled/styled.py}
export FACE=${SD_FACE:-"$SD_ASSETS/faces/palina/dirne.png"}
export FACE_SIZE=${SD_FACE_SIZE:-640}
export SIZE=${SD_SIZE:-10}
export COUNT=${SD_COUNT:-4}
export DIMENSION=${SD_DIMENSION:-"(960, 560)"}
export OBJECT=${SD_OBJECT-""}
export PROMPT=${SD_PROMPT:-"prompt_os"}
export SETTING=${SD_SETTING:-""}
export SWAP=${SD_SWAP:- -1}
export MODS=${SD_MODS:-""}
export TYPES="$SD_TYPES"

