#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ -z ${SHADOWSOCK_PASSWORD} ]]; then
    echo "Please set \${SHADOWSOCK_PASSWORD} at first"
    exit 1
fi

docker-compose -f "${THIS_DIR}/docker-compose.yml" up -d
