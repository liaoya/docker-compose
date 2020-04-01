#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ -f "${THIS_DIR}/.options" ]]; then
    V2RAY_ALTERID=$(grep alterid "${THIS_DIR}/.options" | cut -d"=" -f2)
    V2RAY_PORT=$(grep port "${THIS_DIR}/.options" | cut -d"=" -f2)
    V2RAY_UUID=$(grep uuid "${THIS_DIR}/.options" | cut -d"=" -f2)
else
    V2RAY_ALTERID=${V2RAY_ALTERID:-$((RANDOM % 70 + 30))}
    V2RAY_PORT=${V2RAY_PORT:-$((RANDOM % 10000 + 30000))}
    V2RAY_UUID=${V2RAY_UUID:-$(cat /proc/sys/kernel/random/uuid)}
    {
        echo "alterid=${V2RAY_ALTERID}"
        echo "port=${V2RAY_PORT}"
        echo "uuid=${V2RAY_UUID}"
    } >>"${THIS_DIR}/.options"
    if [[ -f "${THIS_DIR}/config.json" ]]; then rm -f "${THIS_DIR}/config.json"; fi
fi

export V2RAY_ALTERID V2RAY_PORT V2RAY_UUID
