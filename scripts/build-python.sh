#!/bin/bash
set -e

echo "Building Python services"

python3 -m venv venv
source venv/bin/activate

SERVICES=(
emailservice
recommendationservice
shoppingassistantservice
loadgenerator
)

for service in "${SERVICES[@]}"
do
    echo "Installing dependencies for $service"

    cd src/$service

    pip install -r requirements.txt

    cd - > /dev/null
done

echo "Python services build completed"
