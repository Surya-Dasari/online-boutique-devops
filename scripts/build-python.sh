#!/bin/bash
set -e

echo "Packaging Python services"

SERVICES=(
emailservice
recommendationservice
shoppingassistantservice
loadgenerator
)

for service in "${SERVICES[@]}"
do
    echo "Preparing $service"

    cd src/$service

    python3 -m venv venv
    source venv/bin/activate

    pip install -r requirements.txt

    VERSION=$(git rev-parse --short HEAD)

    tar -czf ${service}-${BUILD_NUMBER}-${VERSION}.tar.gz *

    deactivate

    cd - > /dev/null
done

echo "Python services packaged"
