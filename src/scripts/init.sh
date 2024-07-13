#!/usr/bin/env bash

export SD_SCRIPTS=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

set -a
. "$SD_SCRIPTS/../projects/$SD_PROJECT.env"
export SD_PROJECT_NAME="$SD_PROJECT"
set +a

export SD_OUTPUT="$SD_SCRIPTS/../../output/${SD_PROJECT_ALIAS:-$SD_PROJECT}"
export SD_ASSETS="$SD_SCRIPTS/../../assets"

export STYLED=${SD_STYLED:-giger/examples/styled/styled.py}
export FACE=${SD_FACE:-"$SD_ASSETS/faces/palina/dirne.png"}
export SIZE=${SD_SIZE:-10}
export COUNT=${SD_COUNT:-4}
export DIMENSION=${SD_DIMENSION:-"(960, 560)"}
export OBJECT=${SD_OBJECT-""}
export PROMPT=${SD_PROMPT:-"prompt_os"}
export SETTING=${SD_SETTING:-""}
export MODEL=${SD_MODEL:-"Lykon/DreamShaper"}
export SWAP=${SD_SWAP:- -1}
export ENHANCE_FACE=${SD_ENHANCE_FACE:- -1}
export MODS=${SD_MODS:-""}
export CONCAT_MODS=${SD_CONCAT_MODS:- -1}
export TYPES="$SD_TYPES"
export SEED=${SD_SEED:- -1}

export SSH_HOST=${SD_SSH_HOST:-""}

