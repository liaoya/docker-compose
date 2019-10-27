#!/bin/bash

set -a -e -x

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

#shellcheck disable=SC1090
source "${THIS_DIR}/functions.sh"
check_env

function print_usage() {
    local this_file
    this_file=$(basename "${THIS_FILE}")
    echo "${this_file} -h -c[lean] -t <transport>"
}

CLEAN=0
TYPE=""
while getopts ":hct:" opt; do
    case $opt in
    c)
        CLEAN=1 ;;
    h)
        print_usage; exit 0 ;;
    t):
        TYPE="-$OPTARG" ;;
    \?)
        print_usage; exit 1 ;;
    esac
done

if [[ -n ${TYPE} && ! -f "${THIS_DIR}/vmess${TYPE}.json" ]]; then
    echo "Require 'vmess${TYPE}.json'"
    exit 1
fi

if [[ ${CLEAN} -gt 0 ]]; then
    rm -f "${THIS_DIR}/config.json"
fi
#shellcheck disable=SC1090
source "${THIS_DIR}/env.sh"
if [[ ${CLEAN} -gt 0 ]]; then
    docker-compose -f "${THIS_DIR}/docker-compose.yml" down -v
fi
if [[ ! -f "${THIS_DIR}/config.json" ]]; then
#shellcheck disable=SC2002
    cat "${THIS_DIR}/vmess${TYPE}.json" \
        | jq ".inbounds[0].settings.clients[0].alterId=${V2RAY_ALTERID}" \
        | jq ".inbounds[0].port=${V2RAY_PORT}" \
        | jq ".inbounds[0].settings.clients[0].id=\"${V2RAY_UUID}\"" > "${THIS_DIR}/config.json"
fi
docker-compose -f "${THIS_DIR}/docker-compose.yml" up -d
