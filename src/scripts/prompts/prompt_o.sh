#!/usr/bin/env bash

if [[ ! -n "$1" ]]; then
    exit 0
fi

echo "--prompt \"$1\""