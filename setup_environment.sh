#!/bin/bash
set -e

echo "=== Updating system packages ==="
sudo apt-get update
sudo apt-get upgrade -y

echo "=== Installing prerequisites ==="
sudo apt-get install -y ca-certificates curl gnupg lsb-release

echo "=== Setting up Docker repository ==="
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "=== Installing Docker Engine ==="
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "=== Enabling and starting Docker service ==="
sudo systemctl enable docker
sudo systemctl start docker

echo "=== Adding user '$USER' to docker and cdrom groups ==="
sudo usermod -aG docker,cdrom "$USER"

echo "=== Checking /dev/sr* devices ==="
ls -l /dev/sr* || echo "No /dev/sr* devices found. Make sure DVD drives are connected."

echo ""
echo "=== Setup complete! ==="
echo "Please logout and log back in for group changes to take effect."
echo "After that, you can run your ARM Docker container script as your user."

