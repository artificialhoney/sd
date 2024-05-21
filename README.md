# SD

## Standard

### Batch

1. Size: 5
2. Count: 4

### Structure

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

### Workflow

Run steps in order:

1. __render.sh__ (~45min / V100)
2. Delete all corrupted and artifacted images
3. __convert.sh__ (~2min / V100)
4. Move one __preview__ image set in the according folder
5. __layout.sh__ (~0.5min / V100)
6. __meta.sh__ (~0.25min / V100)

```bash
SD_PROJECT=<PROJECT> source sd/src/scripts/init.sh && bash sd/src/scripts/<COMMAND>.sh
```