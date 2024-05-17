#!/bin/bash

export SD_SCRIPTS=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

eval $(cat "$SD_SCRIPTS/../projects/$SD_PROJECT.env")

export SD_OUTPUT="$SD_SCRIPTS/../../output/$SD_STYLE/$SD_PROJECT"
export SD_ASSETS="$SD_SCRIPTS/../../assets"