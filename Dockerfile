FROM debian:stable

ENV TERRAFORM_VERSION=0.12.6

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]

RUN apt-get update -y && \
    apt-get install -y curl jq python bash ca-certificates git openssl unzip wget && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip -O /tmp/google-cloud-sdk.zip && \
    cd /usr/local && unzip /tmp/google-cloud-sdk.zip && \
    google-cloud-sdk/install.sh --usage-reporting=false --path-update=true --bash-completion=true && \
    google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true && \
    rm -rf /tmp/* && \
    apt-get clean && \
    rm -rf /var/tmp/*

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/smark-broad/docker-terraform"
