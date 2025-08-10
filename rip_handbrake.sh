#!/bin/bash
# Another mostly GenAI gem.

DEVICE="/dev/sr0"
OUTPUT_DIR="/home/arm/media/rips"

mkdir -p "$OUTPUT_DIR"

# Function to detect media type by checking for typical Blu-ray or DVD filesystems
detect_media_type() {
    mountpoint="/mnt/temp_disc"

    # Create temp mount directory
    mkdir -p "$mountpoint"

    # Mount device read-only
    mount -o ro "$DEVICE" "$mountpoint" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Failed to mount $DEVICE"
        return 1
    fi

    # Check for Blu-ray structure (BDMV folder)
    if [ -d "$mountpoint/BDMV" ]; then
        media_type="bluray"
    # Check for DVD VIDEO_TS folder
    elif [ -d "$mountpoint/VIDEO_TS" ]; then
        media_type="dvd"
    else
        media_type="unknown"
    fi

    # Unmount the device
    umount "$mountpoint"
    rmdir "$mountpoint"

    echo "$media_type"
}

media_type=$(detect_media_type)

echo "Detected media type: $media_type"

case "$media_type" in
    bluray)
        preset="Fast 1080p30"
        ;;
    dvd)
        preset="Fast 480p30"
        ;;
    *)
        echo "Unknown media type; defaulting to DVD preset"
        preset="Fast 480p30"
        ;;
esac

echo "Using HandBrake preset: $preset"

# Rip title 1 as example; you can expand logic for more titles/discs
HandBrakeCLI -i "$DEVICE" -t 1 -o "$OUTPUT_DIR/output.mp4" --preset="$preset" --decomb --loose-anamorphic

