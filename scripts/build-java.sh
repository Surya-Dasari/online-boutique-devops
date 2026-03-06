#!/bin/bash
set -e

echo "Building Java service"

cd src/adservice

chmod +x gradlew

./gradlew build -x verifyGoogleJavaFormat

VERSION=$(git rev-parse --short HEAD)

cp build/libs/*.jar adservice-${BUILD_NUMBER}-${VERSION}.jar
