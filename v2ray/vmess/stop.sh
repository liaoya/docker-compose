#!/bin/bash

set -a -e

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

#shellcheck disable=SC1091
source "${THIS_DIR}/functions.sh"
check_env
#shellcheck disable=SC1091
source "${THIS_DIR}/env.sh"
docker compose -f "${THIS_DIR}/docker-compose.yml" stop
