FROM ubuntu:14.04

MAINTAINER Andrew Teixeira <teixeira@broadinstitute.org>

ENV TERRAFORM_VERSION=0.6.6 \
    DEBIAN_FRONTEND=noninteractive

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]

RUN apt-get update && \
    apt-get -yq install wget \
    git \
    unzip \
    ca-certificates && \
    wget -P /tmp http://dl.bintray.com/mitchellh/terraform/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    apt-get -yq clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
