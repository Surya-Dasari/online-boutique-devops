#!/bin/bash

SERVICES=()

for dir in src/*; do
    if find "$dir" -name "Containerfile" | grep -q .; then
        service=$(basename "$dir")
        SERVICES+=($service)
    fi
done

echo "${SERVICES[@]}"
