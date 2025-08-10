#!/bin/bash

DEVICE="/dev/sr0"
OUTPUT_DIR="/home/arm/media/rips"

mkdir -p "$OUTPUT_DIR"

# Simple rip of title 1; you can expand logic as needed
HandBrakeCLI -i "$DEVICE" -t 1 -o "$OUTPUT_DIR/output.mp4" --preset="Fast 1080p30" --decomb --loose-anamorphic

