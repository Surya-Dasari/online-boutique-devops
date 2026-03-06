#!/bin/bash
set -e

echo "Building Node services"

SERVICES=(
currencyservice
paymentservice
)

for service in "${SERVICES[@]}"
do
    echo "Installing dependencies for $service"

    cd src/$service

    npm install

    VERSION=$(git rev-parse --short HEAD)

    echo "${service}-${BUILD_NUMBER}-${VERSION}" > build-version.txt

    cd - > /dev/null
done

echo "Node services build completed"
