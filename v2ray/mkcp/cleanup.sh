#!/bin/bash

set -e

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

#shellcheck disable=SC1090
source "${THIS_DIR}/functions.sh"
check_env

function print_usage() {
    local this_file
    this_file=$(basename "${THIS_FILE}")
    echo "${this_file} -h -a[ll]"
}

ALL=0
while getopts ":ha" opt; do
    case $opt in
    a)
        ALL=1 ;;
    h)
        print_usage; exit 0 ;;
    \?)
        print_usage; exit 1 ;;
    esac
done


#shellcheck disable=SC1090
source "${THIS_DIR}/env.sh"

docker-compose -f "${THIS_DIR}/docker-compose.yml" down -v
rm -f "${THIS_DIR}/config.json"
if [[ ${ALL} -gt 0 ]]; then
    rm -f "${THIS_DIR}/.options"
fi
