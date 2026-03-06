#!/bin/bash
set -e

echo "Building NodeJS services"

SERVICES=(
currencyservice
paymentservice
)

for service in "${SERVICES[@]}"
do
    echo "Installing dependencies for $service"

    cd src/$service

    npm install

    cd - > /dev/null
done

echo "NodeJS services build completed"
