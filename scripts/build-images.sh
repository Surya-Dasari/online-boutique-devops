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

pids=()

for service in "${SERVICES[@]}"
do
    echo "Building $service"

    podman build \
    -t localhost/$service:$VERSION \
    src/$service &

    pids+=($!)
done

# wait for builds and detect failures
for pid in "${pids[@]}"
do
    wait $pid
done

echo "All images built successfully"
