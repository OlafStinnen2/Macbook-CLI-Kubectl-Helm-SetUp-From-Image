#!/bin/bash
set -e

echo "Starting gcloud tools container..."

# Set execution rights for scripts in /workspace
chmod +x /workspace/*.sh || true

# Authenticate if not authenticated
if ! gcloud auth list --filter=status:ACTIVE --format="value(account)" | grep -q '.'; then
    echo "No active authentication found. Please log in."
    gcloud auth login --no-launch-browser
fi

# Set project, region, and zone from environment variables if set
if [ ! -z "$GCLOUD_PROJECT" ]; then
    gcloud config set project "$GCLOUD_PROJECT"
fi

if [ ! -z "$GCLOUD_REGION" ]; then
    gcloud config set compute/region "$GCLOUD_REGION"
fi

if [ ! -z "$GCLOUD_ZONE" ]; then
    gcloud config set compute/zone "$GCLOUD_ZONE"
fi

echo "Setup complete. You can now use gcloud, kubectl, and helm."
exec /bin/bash
