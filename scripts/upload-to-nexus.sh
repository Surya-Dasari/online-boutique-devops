#!/bin/bash
set -e

NEXUS_URL="http://localhost:8081/repository/ci-artifacts"
NEXUS_USER="admin"
NEXUS_PASS="password"

echo "Uploading artifacts to Nexus"

find src -type f -name "*-${BUILD_NUMBER}-*" | while read artifact
do
    filename=$(basename "$artifact")

    echo "Uploading $filename"

    curl -u $NEXUS_USER:$NEXUS_PASS \
    --upload-file "$artifact" \
    "$NEXUS_URL/$filename"
done

echo "Upload completed"
