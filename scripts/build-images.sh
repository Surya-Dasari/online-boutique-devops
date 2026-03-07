#!/bin/bash
set -e

echo "Building container images"

SERVICES=(
frontend
productcatalogservice
checkoutservice
shippingservice
currencyservice
paymentservice
emailservice
recommendationservice
shoppingassistantservice
loadgenerator
cartservice
adservice
)

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

for service in "${SERVICES[@]}"
do
    echo "Building image for $service"

    podman build \
        -t $service:$VERSION \
        src/$service

done

echo "Image build completed"
