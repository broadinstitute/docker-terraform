FROM alpine:3.5
ENV TERRAFORM_VERSION=0.8.8
RUN apk update && \
    apk add \
    bash \
    ca-certificates \
    git \
    openssl \
    unzip \
    wget \
    perl && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /cache/apk/* && \
    rm -rf /var/tmp/*

ADD prom-run /
ENTRYPOINT ["/usr/bin/terraform"]
CMD ["--help"]