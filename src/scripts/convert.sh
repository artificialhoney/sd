#!/usr/bin/env bash

IFS=':' read -ra TYPES <<< "$SD_TYPES"

for TYPE in "${TYPES[@]}"; do
    find "$SD_OUTPUT/$TYPE" -maxdepth 1 -type f -name '*.png' -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -progress "{}" -o "{}.webp"
done
