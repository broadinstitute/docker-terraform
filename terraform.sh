#!/bin/bash

DOCKER_IMAGE='broadinstitute/terraform:latest'
SUDO=

SCRIPT_DIR="$( cd -P "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
source "${SCRIPT_DIR}/config.sh"

usage() {
    PROG=`basename $0`
    echo "usage: ${PROG} [--version] [--help] <command> [<args>]"
}

if [ "$TERM" != "dumb" ] ; then
    TTY='-it'
fi

EXTRA_ENV=
if [ -z "${ATLAS_TOKEN}" ]; then
    echo "ATLAS_TOKEN has not been set."
    exit 1
else
    EXTRA_ENV="-e ATLAS_TOKEN=${ATLAS_TOKEN}"
fi

if [ ! -w "${DOCKER_SOCKET}" ];
then
    SUDO='sudo'
fi

if [ -z "$1" ];
    then
    usage
    exit 1
fi

DATA_FQP="$( cd -P "${DATA_DIR}" && pwd )"
if [ ! -d "${DATA_FQP}" ];
    then
    echo "Directory `${DATA_FQP}` does not exist...exiting."
    exit 2
fi

$SUDO docker run $TTY --rm -v $DATA_FQP:/data $EXTRA_ENV $DOCKER_IMAGE $@
