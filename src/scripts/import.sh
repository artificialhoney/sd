#!/usr/bin/env bash



IFS=':' read -ra _TYPES <<<"$TYPES"

for TYPE in "${_TYPES[@]}"; do
    T=$(echo $TYPE | tr a-z A-Z)

    IMAGES=("$SD_OUTPUT"/$TYPE/_selected/*.webp)

    declare -n H="SD_SSH_HOST_${T}"
    _HOST=${H:-$SD_SSH_HOST}

    find "$SD_OUTPUT/$TYPE/_selected -maxdepth 1 -type f -name '*.png.swapped.png.upscaled.png' -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -progress "{}" -o "{}.webp"

    wp media import "$SD_OUTPUT/$TYPE/_selected/*.png.swapped.png.upscaled.png.webp" --ssh=$_HOST
    wp media import "$_" --post_id=123 --featured_image --ssh=$_HOST
done
