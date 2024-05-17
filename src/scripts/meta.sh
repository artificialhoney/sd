#!/bin/bash

SD_META="$SD_OUTPUT/meta.txt"

mkdir -p $SD_OUTPUT

SD_TOP=4

yake -ti "$SD_SETTING" -t $SD_TOP > "$SD_META"
yake -ti "$SD_MUSE $SD_SETTING" -t $SD_TOP >> "$SD_META"
yake -ti "$SD_OBJECT $SD_SETTING" -t $SD_TOP >> "$SD_META"
