#!/bin/bash

echo "Starting SonarQube Scan..."

sonar-scanner \
-Dsonar.projectKey=online-boutique \
-Dsonar.sources=. \
-Dsonar.host.url=http://localhost:9000 \
-Dsonar.exclusions=**/*.java \
-Dsonar.token=$SONAR_TOKEN
