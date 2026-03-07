#!/bin/bash
set -e

echo "Building .NET service"

cd src/cartservice

dotnet restore
dotnet build

VERSION=$(git rev-parse --short HEAD)

cp bin/Debug/net8.0/cartservice.dll cartservice-${BUILD_NUMBER}-${VERSION}.dll
