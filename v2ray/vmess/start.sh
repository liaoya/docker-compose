#!/bin/bash

set -a -e

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

#shellcheck disable=SC1090
source "${THIS_DIR}/functions.sh"
check_env

function print_usage() {
    echo "$(basename "${BASH_SOURCE[0]}") -h -c[lean]"
}

CLEAN=0
while getopts ":hc" opt; do
    case $opt in
    c)
        CLEAN=1
        ;;
    h)
        print_usage
        exit 0
        ;;
    \?)
        print_usage
        exit 1
        ;;
    esac
done

#shellcheck disable=SC1090
source "${THIS_DIR}/env.sh"
if [[ ${CLEAN} -gt 0 ]]; then
    docker-compose -f "${THIS_DIR}/docker-compose.yml" down -v
    rm -f "${THIS_DIR}/config.json"
fi
if [[ ! -f "${THIS_DIR}/config.json" ]]; then
    #shellcheck disable=SC2002
    cat "${THIS_DIR}/vmess${TYPE}.json" |
        jq ".inbounds[0].settings.clients[0].alterId=${V2RAY_ALTERID}" |
        jq ".inbounds[0].port=${V2RAY_PORT}" |
        jq ".inbounds[0].settings.clients[0].id=\"${V2RAY_UUID}\"" |
        jq -S '.' >"${THIS_DIR}/config.json"
fi

if [[ -f "${THIS_DIR}/config.json" ]]; then
    docker-compose -f "${THIS_DIR}/docker-compose.yml" up -d
fi
