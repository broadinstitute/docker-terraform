#!/bin/bash

DOCKER_IMAGE='broadinstitute/terraform:latest'
SUDO=

SCRIPT_DIR="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# shellcheck source=/dev/null
source "${SCRIPT_DIR}/config.sh"

usage() {
    PROG="$(basename "$0")"
    echo "usage: ${PROG} [--version] [--help] <command> [<args>]"
}

if [ "$TERM" != 'dumb' ] ; then
    TTY='-it'
fi

EXTRA_OPTS=
if [ -n "$ATLAS_TOKEN" ]; then
    EXTRA_OPTS="-e ATLAS_TOKEN=${ATLAS_TOKEN}"
fi

if [ "$(uname -s)" != 'Darwin' ]; then
    if [ ! -w "$DOCKER_SOCKET" ]; then
        SUDO='sudo'
    fi
fi

if [ -z "$1" ]; then
    usage
    exit 1
fi

# Map the terraform data directory into the container
DATA_FQP="$( cd -P "${DATA_DIR}" && pwd )"
if [ ! -d "$DATA_FQP" ]; then
    echo "Directory '${DATA_FQP}' does not exist...exiting."
    exit 2
fi

# Map gcloud configuration if it exists
GCLOUD_CONFIG="$( cd -P "${HOME}/.config/gcloud" && pwd )"
if [ -d "$GCLOUD_CONFIG" ]; then
    EXTRA_OPTS="${EXTRA_OPTS} -v ${GCLOUD_CONFIG}:/root/.config/gcloud"
fi

# shellcheck disable=SC2068,SC2086
$SUDO docker run $TTY --rm -v "${DATA_FQP}:/data" $EXTRA_OPTS "$DOCKER_IMAGE" $@
