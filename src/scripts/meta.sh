#!/bin/bash

SD_META="$SD_OUTPUT/meta.yml"

mkdir -p $SD_OUTPUT

SD_TOP=4

cat >"$SD_META" <<-EOF
---
project: $SD_PROJECT_NAME
style: $SD_STYLE
bitter:
    keywords: |
$(yake -ti "$SD_SETTING" -t "$SD_TOP" | tail -4 | sed 's/^/        /')
ginger:
    keywords: |
$(yake -ti "$SD_MUSE $SD_SETTING" -t "$SD_TOP" | tail -4 | sed 's/^/        /')
joy:
    keywords: |
$(yake -ti "$SD_OBJECT $SD_SETTING" -t "$SD_TOP" | tail -4 | sed 's/^/        /')
EOF