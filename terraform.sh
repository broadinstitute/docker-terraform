#!/bin/bash

CERT_COMMANDS=( apply plan push refresh remote taint )
CERTS=0
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

for c in "${CERT_COMMANDS[@]}";
do
    if [ "$1" == "$c" ];
        then
        CERTS=1
    fi
done

INCLUDECERTS=
if [ $CERTS -eq 1 ];
    then
    INCLUDECERTS="-v ${CERTS_DIR}:/etc/ssl/certs:ro --net=host"
fi

$SUDO docker run $TTY --rm -v $DATA_FQP:/data $INCLUDECERTS $DOCKER_IMAGE $@
