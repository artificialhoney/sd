# SD

## Standard

One project contains render information for 3 different styles:

- __ginger__: Background with muse for https://pivoine.art
- __bitter__: Background for YouTube and https://bitter.honeymachine.io
- __joy__: Background with content https://bitter.honeymachine.io

Each style must fulfill following requirements:

1. One __styled__ batch
2. Minimum __13__ selected images

Also, each style will be structured to:

- __instagram__: __4__ random image copies
- __tiktok__: __4__ random image copies
- __preview__: __One__ selected image

### ginger

```bash
# ginger
giger/examples/styled/styled.py "demonic" -o giger/out/batch/demonic/ne/ginger -b ne3 -s $RANDOM -n giger/out/batch/_assets/prompts/negative.txt -d "(960, 560)" --scale 4 --size 10 --count 4 --steps 70 --lora 1.0 --prompt "A photorealistic panorama" --mod "A magnificent white night in beautiful Neon St. Petersburg in hot July with a blooming flora" --mod "A fat big-breasted magnificent sexy romantic russian ginger-haired Ballerina" -f giger/out/batch/_assets/faces/palina/dirne.png --bypass_safety
```


### bitter

```bash
# bitter
giger/examples/styled/styled.py "demonic" -o giger/out/batch/demonic/ne/bitter -b ne1 -s $RANDOM -n giger/out/batch/_assets/prompts/negative.txt -d "(960, 560)" --scale 4 --size 10 --count 4 --steps 70 --lora 1.0 --prompt "A photorealistic panorama" --mod "A magnificent white night in beautiful Neon St. Petersburg in hot July with a blooming flora"
```

### joy

```bash
# joy
giger/examples/styled/styled.py "demonic" -o giger/out/batch/demonic/ne/joy -b ne9 -s $RANDOM -n giger/out/batch/_assets/prompts/negative.txt -d "(560, 960)" --scale 4 --size 10 --count 4 --steps 70 --lora 1.0 --prompt "A photorealistic panorama" --mod "A magnificent white night in beautiful Neon St. Petersburg in hot July with a blooming flora" --mod "Full body shot of a heavily armored and armed hyper-modern stealth warrior with Samurai-Mask and Katana-Sword in dark gray"
```