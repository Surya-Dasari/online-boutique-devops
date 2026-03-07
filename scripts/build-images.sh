#!/bin/bash
set -e

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

SERVICES=$(./scripts/detect-services.sh)

echo "Detected services:"
echo $SERVICES

for service in $SERVICES
do
    echo "Building image for $service"

    podman build \
    -t localhost/$service:$VERSION \
    src/$service
done

echo "All images built"
