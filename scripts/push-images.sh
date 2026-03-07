#!/bin/bash
set -e

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

SERVICES=$(./scripts/detect-services.sh)

echo "Logging into Quay"
podman login quay.io -u $QUAY_USER -p $QUAY_PASS

for service in $SERVICES
do
    echo "Pushing $service"

    podman tag \
    localhost/$service:$VERSION \
    quay.io/suryadasari31/$service:$VERSION

    podman push \
    quay.io/suryadasari31/$service:$VERSION
done
