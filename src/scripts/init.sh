#!/bin/bash

export SD_SCRIPTS=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

set -a
. "$SD_SCRIPTS/../projects/$SD_PROJECT.env"
export SD_PROJECT_NAME="$SD_PROJECT"
set +a

export SD_OUTPUT="$SD_SCRIPTS/../../output/$SD_STYLE/$SD_PROJECT"
export SD_ASSETS="$SD_SCRIPTS/../../assets"
export SD_DIMENSION="(960, 560)"