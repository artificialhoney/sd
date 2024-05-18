#!/usr/bin/env bash

ECHO=""

if [ -n "$2" ]; then
    ECHO="$2"
fi

if [ -n "$1" ]; then
    ECHO="$ECHO, $1"
fi

if [[ ! -n "$ECHO" ]]; then
    exit 0
fi

echo "--prompt \"$ECHO\""