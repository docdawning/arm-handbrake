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
Your system will need Docker setup, I've included what ChatGPT recommends to get set up in an included script:
<pre>
bash setup_environment.sh
</pre>

General good advice is not to blindly run scripts without

<h1>Appendix: Troubleshooting</h1>
Use the docker logs command to see what's going on in the container, this tends to shed a ton of light:
<pre>
docker logs -f arm-handbrake-rippers
</pre>

If neccesary, you can interact with the container environment with:
<pre>
docker exec -it arm-handbrake-rippers /bin/bash
</pre>
