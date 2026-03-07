#!/bin/bash
set -e

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

echo "Building container images"

for service in "${SERVICES[@]}"
do
    echo "Building image for $service"

    podman build \
    -t localhost/$service:$VERSION \
    src/$service &
done

wait

echo "All images built successfully"
