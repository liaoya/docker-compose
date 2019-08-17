#!/bin/bash

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

if [[ -f "${THIS_DIR}/.options" ]]; then
    V2RAY_ALTERID=$(grep alterid "${THIS_DIR}/.options" | cut -d"=" -f2)
    V2RAY_PORT=$(grep port "${THIS_DIR}/.options" | cut -d"=" -f2)
    V2RAY_UUID=$(grep uuid "${THIS_DIR}/.options" | cut -d"=" -f2)
else
    V2RAY_ALTERID=${V2RAY_ALTERID:-$((RANDOM%48+16))}
    V2RAY_PORT=${V2RAY_PORT:-$((RANDOM%30000+20000))}
    V2RAY_UUID=${V2RAY_UUID:-$(cat /proc/sys/kernel/random/uuid)}
    { echo "alterid=${V2RAY_ALTERID}"; echo "port=${V2RAY_PORT}"; echo "uuid=${V2RAY_UUID}"; } >> "${THIS_DIR}/.options"
#shellcheck disable=SC2002
    cat server-template.json \
        | jq ".inbounds[0].settings.clients[0].alterId=${V2RAY_ALTERID}" \
        | jq ".inbounds[0].port=${V2RAY_PORT}" \
        | jq ".inbounds[0].settings.clients[0].id=\"${V2RAY_UUID}\"" > server.json
fi

export V2RAY_ALTERID V2RAY_PORT V2RAY_UUID
