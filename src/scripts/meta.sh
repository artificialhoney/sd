#!/bin/bash

OUTPUT="sd/output/$SD_STYLE/$SD_PROJECT"

SD_META="$OUTPUT/meta.txt"

mkdir -p $OUTPUT

yake -ti "$SD_SETTING" -t 1 > "$SD_META"
yake -ti "$SD_MUSE, $SD_SETTING" -t 1 >> "$SD_META"
yake -ti "$SD_OBJECT, $SD_SETTING" -t 1 >> "$SD_META"
