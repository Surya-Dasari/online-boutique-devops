#!/bin/bash
set -e

echo "Building Java adservice"

cd src/adservice

chmod +x gradlew

./gradlew build -x verifyGoogleJavaFormat

echo "Java service build completed"
