#!/bin/bash
set -e

QUAY_REGISTRY="quay.io/suryadasari31"

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

echo "Logging into Quay"
echo "$QUAY_PASS" | podman login quay.io -u "$QUAY_USER" --password-stdin

for service in "${SERVICES[@]}"
do

    echo "Tagging image $service"

    podman tag \
    localhost/$service:$VERSION \
    $QUAY_REGISTRY/$service:$VERSION

    echo "Pushing image $service"

    podman push \
    $QUAY_REGISTRY/$service:$VERSION

done

echo "All images pushed successfully"
