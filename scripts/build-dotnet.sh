#!/bin/bash
set -e

echo "Building .NET cartservice"

cd src/cartservice/src

dotnet restore
dotnet build

echo "Dotnet service build completed"
