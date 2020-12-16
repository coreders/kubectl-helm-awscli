FROM alpine

ARG KUBECTL_VERSION=1.18.0
ARG HELM_VERSION=3.2.1

RUN apk add --update --no-cache curl ca-certificates bash git python3 && \
    rm -f /var/cache/apk/*

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

ENV HELM_BASE_URL="https://get.helm.sh"
ENV HELM_TAR_FILE="helm-v${HELM_VERSION}-linux-amd64.tar.gz"
RUN curl -L ${HELM_BASE_URL}/${HELM_TAR_FILE} |tar xvz && \
    mv linux-amd64/helm /usr/bin/helm && \
    chmod +x /usr/bin/helm && \
    rm -rf linux-amd64

RUN python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    pip3 install awscli