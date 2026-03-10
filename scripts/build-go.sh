#!/bin/bash
set -e

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

SERVICES=(
frontend
productcatalogservice
checkoutservice
shippingservice
)

for service in "${SERVICES[@]}"
do
    echo "Building $service"

    cd src/$service

    go build -o ${service}-${VERSION}

    cd - > /dev/null
done

echo "Go services build completed"
