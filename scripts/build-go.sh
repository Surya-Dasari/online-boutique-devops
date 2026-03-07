#!/bin/bash
set -e

VERSION=$(git rev-parse --short HEAD)

SERVICES=(
frontend
productcatalogservice
checkoutservice
shippingservice
)

for service in "${SERVICES[@]}"
do
    echo "Building Go service $service"

    cd src/$service

    go build -o $service

    cd - > /dev/null
done
