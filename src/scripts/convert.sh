#!/bin/bash

OUTPUT="sd/output/$SD_STYLE/$SD_PROJECT"

find $OUTPUT -type f -name '*.png' -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -progress "{}" -o "{}.webp"