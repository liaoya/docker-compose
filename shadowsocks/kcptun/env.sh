#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ -f "${THIS_DIR}/.options" ]]; then
    KCPTUN_PORT=$(grep -e "^kcptun_port=" "${THIS_DIR}/.options" | cut -d"=" -f2)
    SHADOWSOCK_PASSWORD=$(grep -e "^password=" "${THIS_DIR}/.options" | cut -d"=" -f2)
    SHADOWSOCK_PORT=$(grep -e "^port=" "${THIS_DIR}/.options" | cut -d"=" -f2)
else
    KCPTUN_PORT=${KCPTUN_PORT:-$((RANDOM % 30000 + 10000))}
    SHADOWSOCK_PASSWORD=${SHADOWSOCK_PASSWORD:-$(tr -cd '[:alnum:]' </dev/urandom | fold -w30 | head -n1)}
    SHADOWSOCK_PORT=${SHADOWSOCK_PORT:-$((RANDOM % 30000 + 10000))}
    {
        echo "kcptun_port=${KCPTUN_PORT}"
        echo "password=${SHADOWSOCK_PASSWORD}"
        echo "port=${SHADOWSOCK_PORT}"
    } >>"${THIS_DIR}/.options"
fi
export KCPTUN_PORT SHADOWSOCK_PASSWORD SHADOWSOCK_PORT
