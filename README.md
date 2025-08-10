<h1>arm-handbrake Project</h1>
This project is my little mod to the standard arm (automatic ripping machine) Docker image so that it defaults over to using Handbrake 
for decoding DVDs (and presumably Blurays) instead of MakeMKV. I've cobbled this together, no guarantees.

Use of this is at your own risk/disgretion/liability, etc. I use this to backup my content that I have archived already.

<h1>Quickstart</h1>
Quick and dirty, there's how to use this on your Docker-endowed Linux host.

Run this:
<pre>
echo "Get the repo from GitHub"
git clone https://github.com/docdawning/arm-handbrake ~/arm-handbrake.git

echo "Change working directories in to the repo"
cd ~/arm-handbrake.git

echo "Copy and update the start script"
cp TEMPLATE_start-arm-handbrake-container.sh start-arm-handbrake-container.sh

echo "Now edit the start-arm-handbrake-container.sh to set the path to where ARM will store stuff to something that suits your environment."

echo "Once done editing, run the script to get the container started, use:"
echo "bash start-arm-handbrake-container.sh"
</pre>


<h1>Pre-requsities</h1>
Your system will need Docker setup, here's what ChatGPT recommends to get set up:
<pre>
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
</pre>

This is also provided in the script "setup_environment.sh", which you can run with:
<pre>
bash setup_environment.sh
</pre>

<h1>Appendix: Troubleshooting</h1>
Use the docker logs command to see what's going on in the container, this tends to shed a ton of light:
<pre>
docker logs -f arm-handbrake-rippers
</pre>

If neccesary, you can interact with the container environment with:
<pre>
docker exec -it arm-handbrake-rippers /bin/bash
</pre>
