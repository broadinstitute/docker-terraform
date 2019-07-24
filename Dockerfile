FROM debian:stable

ENV TERRAFORM_VERSION=0.11.14
ENV GO_VERSION=go1.12.7

VOLUME ["/data"]

WORKDIR /data

ENTRYPOINT ["/usr/bin/terraform"]

CMD ["--help"]

ENV PATH = $PATH:/usr/local/google-cloud-sdk/bin
ENV PATH = $PATH:/usr/local/go/bin
ENV GOPATH /root/go

RUN apt-get update -y && \
    apt-get install -y curl jq python bash ca-certificates git openssl unzip wget && \
    cd /tmp && \
    wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
    unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/bin && \
    wget https://dl.google.com/dl/cloudsdk/channels/rapid/google-cloud-sdk.zip -O /tmp/google-cloud-sdk.zip && \
    cd /usr/local && unzip /tmp/google-cloud-sdk.zip && \
    google-cloud-sdk/install.sh --usage-reporting=false --path-update=true --bash-completion=true && \
    google-cloud-sdk/bin/gcloud config set --installation component_manager/disable_update_check true && \
    wget https://dl.google.com/go/${GO_VERSION}.linux-amd64.tar.gz && tar -xzvf ${GO_VERSION}.linux-amd64.tar.gz -C /usr/local && \
    /usr/local/google-cloud-sdk/bin/gcloud components install kubectl && \
    /usr/local/go/bin/go get -u github.com/banzaicloud/terraform-provider-k8s && \
    rm -rf /tmp/* && \
    apt-get clean && \
    rm -rf /var/tmp/*

COPY terraformrc.txt /root/.terraformrc

ARG VCS_REF

LABEL org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/broadinstitute/docker-terraform"
