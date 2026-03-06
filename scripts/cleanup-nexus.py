import requests
import os
from collections import defaultdict

NEXUS_URL = "http://localhost:8081"
REPO = "ci-artifacts"

user = os.environ["NEXUS_USER"]
password = os.environ["NEXUS_PASS"]

session = requests.Session()
session.auth = (user, password)

components = []
url = f"{NEXUS_URL}/service/rest/v1/components?repository={REPO}"

while url:
    r = session.get(url)
    data = r.json()
    components.extend(data["items"])
    url = data.get("continuationToken")
    if url:
        url = f"{NEXUS_URL}/service/rest/v1/components?repository={REPO}&continuationToken={url}"

services = defaultdict(list)

for comp in components:
    name = comp["name"]
    version = comp["version"]
    services[name].append((version, comp["id"]))

for svc in services:
    services[svc].sort(reverse=True)

    for old in services[svc][2:]:
        cid = old[1]
        print(f"Deleting old artifact for {svc}: {old[0]}")
        session.delete(f"{NEXUS_URL}/service/rest/v1/components/{cid}")
