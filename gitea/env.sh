#!/bin/bash
#shellcheck disable=SC2034

set +e

GITEA_VERSION=${GITEA_VERSION:-1.11.0}
GITEA_ADMIN=${GITEA_ADMIN:-giteadmin}
GITEA_ADMIN_PASSWORD=${GITEA_ADMIN_PASSWORD:-admin123}
if [[ -z ${DOMAIN} ]]; then
    DOMAIN=$(hostname -f) || DOMAIN=$(hostname)
    echo "${DOMAIN}" | grep -s -q -e "\\." || DOMAIN=$(hostname -I | cut -d " " -f 1)
    EMAIL_DOMAIN=$(hostname -f)
else
    EMAIL_DOMAIN=${DOMAIN}
fi
HTTP_PORT=${HTTP_PORT:-13000}
SSH_PORT=${SSH_PORT:-10022}
GITEA_URL=http://${DOMAIN}:${HTTP_PORT}/

DEMO_USER_NAME=${DEMO_USER_NAME:-$(id -un)}
DEMO_USER_PASSWORD=${DEMO_USER_PASSWORD:-gitea}
DEMO_USER_IS_ADMIN=${DEMO_USER_IS_ADMIN:-1}
DEMO_ORG_NAME=${DEMO_ORG_NAME:-demo-org}
DEMO_REPO_NAME=${DEMO_REPO_NAME:-demo-repo}
