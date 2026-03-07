#!/bin/bash
set -e

echo "Building .NET service"

cd src/cartservice

# restore dependencies
dotnet restore cartservice.csproj

# build project
dotnet build cartservice.csproj --configuration Release

VERSION=${BUILD_NUMBER}-$(git rev-parse --short HEAD)

# copy artifact
cp bin/Release/net8.0/cartservice.dll cartservice-${VERSION}.dll

echo ".NET build completed"
