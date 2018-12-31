FROM debian:buster

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /tmp

# Install common dependencies
RUN apt-get update \
    && apt-get install -y curl gnupg unzip jq make apt-utils wget lsb-release

# Install GCP SDK
RUN echo "deb http://packages.cloud.google.com/apt cloud-sdk-$(lsb_release --codename -s) main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
     && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
     && apt-get update \
     && apt-get install -y google-cloud-sdk

# Install Kubernetes tools
RUN apt-get install -y kubectl kubectx

# Install Helm
RUN mkdir -p /tmp/helm \
    && cd /tmp/helm \
    && wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz -O ./helm.tar.gz \
    && tar -zxvf /tmp/helm/helm.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/helm \
    && rm -rf /tmp/helm

# Install latest Terraform
RUN mkdir -p /tmp/terraform \
    && cd /tmp/terraform \
    && wget $(curl -sL https://releases.hashicorp.com/terraform/index.json | jq -r '.versions[].builds[].url' | sort -t. -k 1,1n -k 2,2n -k 3,3n -k 4,4n | egrep -v 'rc|beta|alpha' | egrep 'linux.*amd64' | tail -1) -O ./terraform.zip \
    && unzip ./terraform.zip \
    && mv terraform /usr/local/bin/terraform

WORKDIR /