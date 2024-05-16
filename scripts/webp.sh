#!/bin/bash

find . -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | xargs -0 -I{} -r -n1 -P10 cwebp -z 9 -m 6 -mt -pass 10 -alpha_filter best -short -progress "{}" -o "{}.webp"
rename "s/png\.webp$/webp/" *.webp