# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.148.1/containers/alpine/.devcontainer/base.Dockerfile

# [Choice] Alpine version: 3.12, 3.11, 3.10
ARG VARIANT="3.12"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-alpine-${VARIANT}

ARG TERRAFORM_VERSION
ENV TERRAFORM_VERSION=$TERRAFORM_VERSION

# ** [Optional] Uncomment this section to install additional packages. **
RUN apk update \
    && apk add --no-cache \ 
    libc6-compat \
    git \
    openssh-client \
    unzip \
    python3 \
    py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install awscli \
    && curl https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && mv terraform /usr/bin \
    && rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && rm -rf /var/cache/apk/*
