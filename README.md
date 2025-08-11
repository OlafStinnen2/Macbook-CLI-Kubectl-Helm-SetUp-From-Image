# GCloud Tools Docker Container

This project provides a Docker container with Google Cloud SDK, kubectl, and Helm installed for easy GKE cluster management.

---

## Prerequisites

- Docker installed on your machine
- Google Cloud account with necessary permissions
- Enable Google Kubernetes Engine API in your project via Google Cloud Console
- Start this project by creating a folder on your machine called "Projects".
- Copy the files into this folder and start with building the image.

---

## Build the Docker Image

```bash
docker build -t gcloud-tools:latest -f Dockerfile.gcloud .
```

---

## Run the Container

Mount your local project directory and pass environment variables for project, region, and zone:

```bash
docker run -it -v /Users/$USER/Projects:/workspace \
  -e GCLOUD_PROJECT=your-gcp-project-id \
  -e GCLOUD_REGION=your-region \
  -e GCLOUD_ZONE=your-zone \
  gcloud-tools:latest
```

---

## Authentication

On first run inside the container, you will be prompted to authenticate:

1. Follow the URL printed in the terminal.
2. Authenticate with your Google account.
3. Paste the verification code back into the terminal.

---

## Create a GKE Cluster

Inside the container, run:

```bash
./gke-setup.sh <cluster-name>
```

*Note*: Cluster name must be lowercase, start with a letter, and contain only letters, numbers, and dashes.

---

## Delete a GKE Cluster

To delete a cluster, run:

```bash
gcloud container clusters delete <cluster-name> --region $GCLOUD_REGION --project $GCLOUD_PROJECT
```

---

## Test Commands

- **Check gcloud version:**

  ```bash
  gcloud version
  ```

- **Check kubectl version and cluster connectivity:**

  ```bash
  kubectl version --client
  kubectl get nodes
  ```

- **Check helm version:**

  ```bash
  helm version
  ```

---

## Notes

- If you encounter an error about `gke-gcloud-auth-plugin`, it is installed in the container; make sure to restart the container after image build.
- Adjust the node count and machine type in `gke-setup.sh` to fit your project quota.
