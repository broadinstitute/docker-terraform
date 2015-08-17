FROM alpine:3.2

MAINTAINER Andrew Teixeira <teixeira@broadinstitute.org>

ENV TERRAFORM_VERSION 0.6.1

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]

RUN apk add --update wget
    unzip \
    ca-certificates && \
    wget -P /tmp http://dl.bintray.com/mitchellh/terraform/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -f /var/cache/apk/*
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*
