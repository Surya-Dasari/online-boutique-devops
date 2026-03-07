#!/bin/bash
set -e

echo "Building container images in parallel"

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

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

build_image() {

    service=$1

    echo "Building $service"

    podman build \
        -t $service:$VERSION \
        src/$service

}

for svc in "${SERVICES[@]}"
do
    build_image $svc &
done

wait

echo "All images built successfully"
