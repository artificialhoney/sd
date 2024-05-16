#!/bin/bash

STYLE=${STYLE:-"demonic"}
PROJECT=${PROJECT:-"xx"}
OUTPUT="sd/output/$STYLE/$PROJECT"

OUTPUT="sd/output/$STYLE/$PROJECT"

find $OUTPUT -type f -name '*.png' -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -progress "{}" -o "{}.webp"