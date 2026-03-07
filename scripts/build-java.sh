#!/bin/bash
set -e

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

echo "Building Java service"

cd src/adservice

chmod +x gradlew

./gradlew build -x verifyGoogleJavaFormat

JAR=$(ls build/libs/*.jar | head -1)

cp $JAR adservice-${VERSION}.jar

cd - > /dev/null

echo "Java build completed"
