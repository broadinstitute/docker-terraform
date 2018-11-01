FROM alpine:3.8

ENV TERRAFORM_VERSION=0.11.8

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]

RUN apk update && \
    apk add curl jq python bash ca-certificates git openssl unzip wget && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /var/tmp/* && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip -O /tmp/google-cloud-sdk.zip && \
    cd /usr/local && unzip /tmp/google-cloud-sdk.zip && \
    google-cloud-sdk/install.sh --usage-reporting=false --path-update=true --bash-completion=true && \
    google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true

ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/broadinstitute/docker-terraform"
