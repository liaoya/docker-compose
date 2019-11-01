#!/bin/bash

set -a -e -x

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

function print_usage() {
    local this_file
    this_file=$(basename "${THIS_FILE}")
    echo "${this_file} -h -c[lean]"
}

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
