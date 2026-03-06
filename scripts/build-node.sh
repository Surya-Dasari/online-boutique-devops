#!/bin/bash
set -e

echo "Packaging NodeJS services"

SERVICES=(
currencyservice
paymentservice
)

for service in "${SERVICES[@]}"
do
    echo "Preparing $service"

    cd src/$service

    npm install

    VERSION=$(git rev-parse --short HEAD)

    tar -czf ${service}-${BUILD_NUMBER}-${VERSION}.tar.gz *

    cd - > /dev/null
done

echo "Node services packaged"
