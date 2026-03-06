#!/bin/bash
set -e

echo "Building Go services"

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

    VERSION=$(git rev-parse --short HEAD)

    rm -f ${service}-*

    go build -o ${service}-${BUILD_NUMBER}-${VERSION}

    cd - > /dev/null
done

echo "Go services build completed"
