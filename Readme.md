[![](https://images.microbadger.com/badges/image/cagataygurturk/gcp-toolkit.svg)](https://microbadger.com/images/cagataygurturk/gcp-toolkit)

# GCP Toolkit Docker Image

This Docker image includes some tools one may need for developing on GCP. The image is based on Debian busty and includes:

- Terraform (latest stable version)
- Google Cloud SDK
- kubectl, kubectx, helm

## Usage

You can run bash with the container image and mount your local directory to a directory inside the container.

```bash
docker run -v ${PWD}:/workspace -it cagataygurturk/gcp-toolkit:latest /bin/bash
```