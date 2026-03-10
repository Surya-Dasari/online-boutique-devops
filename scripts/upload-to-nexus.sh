#!/bin/bash
set -e

echo "Uploading artifacts to Nexus"

NEXUS_URL="http://localhost:8081/repository/ci-artifacts"

find src -type f -name "*-${BUILD_NUMBER}-*" | while read artifact
do
    filename=$(basename "$artifact")

    echo "Uploading $filename"

    curl --fail -u "$NEXUS_USER:$NEXUS_PASS" \
    --upload-file "$artifact" \
    "$NEXUS_URL/$filename"
done

echo "Upload completed"
