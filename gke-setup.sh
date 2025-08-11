#!/bin/bash
set -e

CLUSTER_NAME=$1

if [ -z "$CLUSTER_NAME" ]; then
    echo "Usage: $0 <cluster-name>"
    exit 1
fi

echo "Starting GKE cluster setup for cluster: $CLUSTER_NAME"

PROJECT=$(gcloud config get-value project)
REGION=$(gcloud config get-value compute/region)
ZONE=$(gcloud config get-value compute/zone)

echo "Project: $PROJECT"
echo "Region: $REGION"
echo "Zone: $ZONE"

echo "Creating GKE cluster with smaller node configuration..."

# Create GKE cluster with smaller nodes to reduce quota consumption
gcloud container clusters create "$CLUSTER_NAME" \
    --region "$REGION" \
    --num-nodes=1 \
    --machine-type=e2-medium \
    --cluster-ipv4-cidr=10.0.0.0/14

echo "Fetching cluster credentials..."

gcloud container clusters get-credentials "$CLUSTER_NAME" --region "$REGION" --project "$PROJECT"

echo "Cluster $CLUSTER_NAME successfully created and configured."
