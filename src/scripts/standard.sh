#!/bin/bash

export STYLED=giger/examples/styled/styled.py

export STYLE="demonic"
export PROJECT="rm"
export OUTPUT="sd/output/$STYLE/$PROJECT"
export PROMPT="A photorealistic panorama"
export SETTING="A magnificent white night in beautiful Neon St. Petersburg in hot July with a blooming flora"
export MUSE="A fat big-breasted magnificent sexy romantic russian ginger-haired Ballerina"
export OBJECT="Highly detailed full body shot of a strong bad heavily full armored hyper-modern combat stealth doom death Warrior in dark gray teflon carbon"
export FACE="sd/assets/faces/palina/dirne.png"

export DIMENSION="(960, 560)"
export SIZE=10
export COUNT=4

# Prepare
rm -rf "$OUTPUT"

# ginger
export TYPE="ginger"
$STYLED "$STYLE" -o "$OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$PROMPT" --mod "$SETTING" --mod "$MUSE" -f "$FACE" --bypass_safety

# bitter
export TYPE="bitter"
$STYLED "$STYLE" -o "$OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$PROMPT" --mod "$SETTING" --bypass_safety

# bitter
export TYPE="joy"
$STYLED "$STYLE" -o "$OUTPUT" -b "$TYPE" -s $RANDOM -d "$DIMENSION" --scale 4 --size $SIZE --count $COUNT --steps 70 --lora 1.0 --prompt "$PROMPT" --mod "$SETTING" --mod "$OBJECT" --bypass_safety


# Cleanup
find "$OUTPUT/**" -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -z 9 -m 6 -mt -pass 10 -alpha_filter best -short -progress "{}" -o "{}.webp"
rename "s/png\.webp$/webp/" "$OUTPUT/**/*.webp"