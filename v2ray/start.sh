#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

function check_command() {
    local prog
    prog=$1
    if [[ -z $(command -v "${prog}") ]]; then
        echo "${prog} is required"
        exit 1
    fi
}

function check_env() {
    check_command docker
    check_command docker-compose
    check_command jq
}

function print_usage() {
    local this_file
    this_file=$(basename "${THIS_FILE}")
    echo "${this_file} -h -c[lean]"
}

check_env

CLEAN=0
while getopts ":hc" opt; do
    case $opt in
    c)
        CLEAN=1 ;;
    h)
        print_usage; exit 0 ;;
    \?)
        print_usage; exit 1 ;;
    esac
done

if [[ ${CLEAN} -gt 0 ]]; then
    rm -f "${THIS_DIR}/.options"
fi
#shellcheck disable=SC1090
source "${THIS_DIR}/env.sh"
if [[ ${CLEAN} -gt 0 ]]; then
    docker-compose -f "${THIS_DIR}/docker-compose.yml" down -v
fi
docker-compose -f "${THIS_DIR}/docker-compose.yml" up -d
