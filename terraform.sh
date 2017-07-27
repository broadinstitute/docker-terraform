#!/bin/bash

IMAGE_NAME="terraformtask"
IMAGE_ID=$(docker images -q $IMAGE_NAME)
if [ -z "$IMAGE_ID" ]; then
  docker build -t $IMAGE_NAME .
fi

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

if [ -z "$1" ]; then
    usage
    exit 1
fi

DATA_FQP="$( cd -P "${DATA_DIR}" && pwd )"
if [ ! -d "${DATA_FQP}" ]; then
    echo "Directory `${DATA_FQP}` does not exist...exiting."
    exit 2
fi

$SUDO docker run $TTY --rm \
-e AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
-e AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY" \
-v $DATA_FQP:/data $IMAGE_NAME $@
