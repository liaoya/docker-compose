#!/bin/bash
#shellcheck disable=SC2034

set +ae

GITEA_VERSION=${GITEA_VERSION:-$(curl -sL "https://api.github.com/repos/go-gitea/gitea/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')}
GITEA_VERSION=${GITEA_VERSION:1.12.3}

if [[ -z ${DOMAIN} ]]; then
    DOMAIN=$(hostname -f) || DOMAIN=$(hostname)
    echo "${DOMAIN}" | grep -s -q -e "\\." || DOMAIN=$(hostname -I | cut -d " " -f 1)
fi
HTTP_PORT=${HTTP_PORT:-13000}
SSH_PORT=${SSH_PORT:-10022}
GITEA_URL=http://${DOMAIN}:${HTTP_PORT}/
export DOMAIN GITEA_URL GITEA_VERSION HTTP_PORT SSH_PORT

# GITEA_ADMIN=${GITEA_ADMIN:-giteadmin}
# GITEA_ADMIN_PASSWORD=${GITEA_ADMIN_PASSWORD:-admin123}
# DEMO_USER_NAME=${DEMO_USER_NAME:-$(id -un)}
# DEMO_USER_PASSWORD=${DEMO_USER_PASSWORD:-gitea}
# DEMO_USER_IS_ADMIN=${DEMO_USER_IS_ADMIN:-1}
# DEMO_ORG_NAME=${DEMO_ORG_NAME:-demo-org}
# DEMO_REPO_NAME=${DEMO_REPO_NAME:-demo-repo}
