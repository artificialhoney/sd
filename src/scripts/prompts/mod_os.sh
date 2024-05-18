#!/usr/bin/env bash

ECHO=""

if [ -n "$1" ]; then
    ECHO="--mod \"$1\""
fi

if [ -n "$2" ]; then
    ECHO="$ECHO --mod \"$2\""
fi

if [[ ! -n "$ECHO" ]]; then
    exit 0
fi

echo "$ECHO --prompt \"\""