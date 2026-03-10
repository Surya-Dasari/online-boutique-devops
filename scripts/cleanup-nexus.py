import requests
import os
import re
from collections import defaultdict

NEXUS = "http://localhost:8081"
REPO = "ci-artifacts"

user = os.environ["NEXUS_USER"]
password = os.environ["NEXUS_PASS"]

url = f"{NEXUS}/service/rest/v1/search/assets?repository={REPO}"

assets = []

while url:
    r = requests.get(url, auth=(user, password))
    data = r.json()

    assets.extend(data["items"])

    token = data.get("continuationToken")
    if token:
        url = f"{NEXUS}/service/rest/v1/search/assets?repository={REPO}&continuationToken={token}"
    else:
        url = None


services = defaultdict(list)

for asset in assets:

    filename = asset["path"].lstrip("/")   # remove leading slash

    match = re.match(r"([a-zA-Z0-9]+)-(\d+)-", filename)

    if match:

        service = match.group(1)
        build = int(match.group(2))

        services[service].append((build, asset["id"], filename))


for service in services:

    versions = sorted(services[service], reverse=True)

    for old in versions[2:]:

        asset_id = old[1]
        name = old[2]

        print(f"Deleting old artifact: {name}")

        requests.delete(
            f"{NEXUS}/service/rest/v1/assets/{asset_id}",
            auth=(user, password)
        )
