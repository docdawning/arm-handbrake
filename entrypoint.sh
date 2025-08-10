#!/bin/bash
# The point of this entrypoint script is to update the ARM config to use handbrake as the ripper method
# rather than the default of makemkv

set -e

CONFIG_FILE="/etc/arm/config/arm.yaml"

echo "Ensuring ARM config uses handbrake as ripper..."

if grep -q 'RIPPER:' "$CONFIG_FILE"; then
  sed -i 's/^RIPPER:.*$/RIPPER: handbrake/' "$CONFIG_FILE"
else
  echo "RIPPER: handbrake" >> "$CONFIG_FILE"
fi

echo "Starting ARM service..."
exec /sbin/my_init  # or whatever the original entrypoint is

