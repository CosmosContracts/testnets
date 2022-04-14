#!/bin/sh

find ./gentx -iname "*.json" -print0 |
    while IFS= read -r -d '' line; do
        echo $(jq -r '.body.messages[0].delegator_address' $line)
    done