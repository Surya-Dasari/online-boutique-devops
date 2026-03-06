import subprocess

scripts = [
    "scripts/build-go.sh",
    "scripts/build-node.sh",
    "scripts/build-python.sh",
    "scripts/build-dotnet.sh",
    "scripts/build-java.sh"
]

for script in scripts:
    print(f"Running {script}")
    subprocess.run(["bash", script], check=True)
