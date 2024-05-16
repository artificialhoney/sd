#!/bin/bash

STYLE=${STYLE:-"demonic"}
PROJECT=${PROJECT:-"xx"}
OUTPUT="sd/output/$STYLE/$PROJECT"

META="$OUTPUT/meta.txt"

rm -rf "$META"

yake -ti "$SETTING" -t 1 >> $META
yake -ti "$MUSE, $SETTING" -t 1 >> $META
yake -ti "$OBJECT, $SETTING" -t 1 >> $META
