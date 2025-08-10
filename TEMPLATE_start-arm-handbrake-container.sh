#!/bin/bash

#### MUST BE UPDATED BY USER ##########################
ARM_CONFIG_DIR="/home/j/arm-handbrake/arm-config"
ARM_LOGS="/home/j/arm-handbrake/arm-logs"
ARM_MEDIA_DIR="/home/j/arm-handbrake/Media"
ARM_MUSIC_DIR="/home/j/arm-handbrake/Music"

#### OPTIONAL CONFIGURABLES ###########################
ARM_USER_ID=1000
ARM_GROUP_ID=1000

#### DON'T CHANGE, UNLESS YOU HAVE A REAL REASON ######
ARM_IMAGE="docdawning/arm-handbrake:latest"

#### TIME TO ACT ######################################
echo -e "\nMaking pre-req dirs as necessary"
mkdir -p "$ARM_CONFIG_DIR" "$ARM_LOGS" "$ARM_MEDIA_DIR" "$ARM_MUSIC_DIR"

# Ensure ARM config file exists, and set RIPMETHOD to handbrake
ARM_CONFIG_FILE="$ARM_CONFIG_DIR/arm.yaml"

if [ ! -f "$ARM_CONFIG_FILE" ]; then
  echo -e "Creating ARM config file at $ARM_CONFIG_FILE"
  echo "RIPMETHOD: handbrake" > "$ARM_CONFIG_FILE"
else
  # If RIPMETHOD line exists, replace it; otherwise append it
  if grep -q '^RIPMETHOD:' "$ARM_CONFIG_FILE"; then
    sed -i 's/^RIPMETHOD:.*/RIPMETHOD: handbrake/' "$ARM_CONFIG_FILE"
  else
    echo "RIPMETHOD: handbrake" >> "$ARM_CONFIG_FILE"
  fi
fi

echo -e "\nFetching latest of $ARM_IMAGE"
docker pull $ARM_IMAGE

echo -e "\nStarting container instance of $ARM_IMAGE"
docker run -d \
    -p "8080:8080" \
    -e TZ="America/Edmonton" \
    -v "$ARM_CONFIG_DIR:/etc/arm/config" \
    -v "$ARM_LOGS:/home/arm/logs" \
    -v "$ARM_MUSIC_DIR:/home/arm/music" \
    -v "$ARM_MEDIA_DIR:/home/arm/media" \
    --device="/dev/sr0:/dev/sr0" \
    --device="/dev/sr1:/dev/sr1" \
    --device="/dev/sr2:/dev/sr2" \
    --device="/dev/sr3:/dev/sr3" \
    -e ARM_UID="$ARM_USER_ID" \
    -e ARM_GID="$ARM_GROUP_ID" \
    --privileged \
    --restart "always" \
    --name "arm-handbrake-rippers" \
    --cpuset-cpus='0,1,2,3' \
    $ARM_IMAGE

echo -e "\nConfiguration complete."

