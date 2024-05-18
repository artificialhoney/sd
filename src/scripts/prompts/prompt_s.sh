#!/usr/bin/env bash

if [[ ! -n "$2" ]]; then
    exit 0
fi

echo "--prompt \"$2\""