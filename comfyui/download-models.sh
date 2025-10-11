#!/bin/bash
echo "########################################"
echo "[INFO] Downloading Models..."
echo "########################################"

# Models
cd /root/ComfyUI/models
INPUT_FILE=/runner-scripts/download-models.txt
touch $INPUT_FILE
aria2c \
  --input-file=$INPUT_FILE \
  --allow-overwrite=false \
  --auto-file-renaming=false \
  --continue=true \
  --max-connection-per-server=5

# Finish
touch /root/.download-complete
