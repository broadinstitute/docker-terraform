FROM alpine:3.2

MAINTAINER Andrew Teixeira <teixeira@broadinstitute.org>

ENV TERRAFORM_VERSION=0.6.11

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]

RUN apk update && \
    apk add bash \
    ca-certificates \
    git \
    openssl \
    unzip \
    wget && \
    wget -P /tmp https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
