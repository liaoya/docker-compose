#!/bin/bash

set -e -x

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

#shellcheck disable=SC1090
source "${THIS_DIR}/functions.sh"
check_env

#shellcheck disable=SC1090
source "${THIS_DIR}/env.sh"

docker-compose -f "${THIS_DIR}/docker-compose.yml" down -v
rm -f "${THIS_DIR}/config.json"
rm -f "${THIS_DIR}/.options"
