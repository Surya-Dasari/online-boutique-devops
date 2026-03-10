#!/bin/bash
set -e

echo "Starting  SonarQube Scan ..."

sonar-scanner \
  -Dsonar.projectKey=my-project \
  -Dsonar.sources=. \
  -Dsonar.host.url=http://localhost:9000 \
  -Dsonar.login=$SONAR_TOKEN

echo "SonarQube scan completed"

