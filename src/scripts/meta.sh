#!/bin/bash

SD_META="$SD_OUTPUT/meta.txt"

mkdir -p $SD_OUTPUT

yake -ti "$SD_SETTING" -t 1 > "$SD_META"
yake -ti "$SD_MUSE, $SD_SETTING" -t 1 >> "$SD_META"
yake -ti "$SD_OBJECT, $SD_SETTING" -t 1 >> "$SD_META"
