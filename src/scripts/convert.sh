#!/usr/bin/env bash

find $SD_OUTPUT -type f -name '*.png' -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -progress "{}" -o "{}.webp"