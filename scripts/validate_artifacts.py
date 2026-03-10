import os
import sys

expected_services = [
"frontend",
"productcatalogservice",
"checkoutservice",
"shippingservice"
]

build = os.environ.get("BUILD_NUMBER")

if not build:
    print("BUILD_NUMBER not set")
    sys.exit(1)

errors = 0

for service in expected_services:

    path = f"src/{service}"

    files = os.listdir(path)

    matched = False

    for f in files:
        if f.startswith(service + "-" + build):
            matched = True

    if not matched:
        print(f"Missing versioned artifact for {service}")
        errors += 1
    else:
        print(f"{service} artifact verified")

if errors > 0:
    sys.exit(1)

print("All artifacts validated successfully")
