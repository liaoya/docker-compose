#!/usr/bin/env bash

[[ $(command -v http) ]] || { echo "http command is required"; exit 1; }

GITEA_ADMIN=${GITEA_ADMIN:-giteadmin}
GITEA_ADMIN_PASSWORD=${GITEA_ADMIN_PASSWORD:-admin123}
if [[ -z ${DOMAIN} ]]; then
    DOMAIN=$(hostname -f)
    echo ${DOMAIN} | grep -s -q "\." || DOMAIN=$(hostname -I | cut -d " " -f 1)
    EMAIL_DOMAIN=$(hostname -f)
else
    EMAIL_DOMAIN=${DOMAIN}
fi
HTTP_PORT=${HTTP_PORT:-13000}
SSH_PORT=${SSH_PORT:-10022}
GITEA_URL=http://${DOMAIN}:${HTTP_PORT}/

http --timeout 120 -f POST :13000/install \
     db_type=SQLite3 db_path=/data/gitea/gitea.db \
     app_name="Gitea Repository" repo_root_path="/data/git/repositories" lfs_root_path="" \
     ssl_mode=disable run_user=git \
     domain=${DOMAIN} ssh_port=${SSH_PORT} http_port=3000 app_url="${GITEA_URL}" \
     log_root_path="/data/gitea/log" \
     disable_registration=on require_sign_in_view=on \
     no_reply_address="noreply.org" \
     admin_name=${GITEA_ADMIN} admin_passwd=${GITEA_ADMIN_PASSWORD} admin_confirm_passwd=${GITEA_ADMIN_PASSWORD} admin_email="${GITEA_ADMIN}@${EMAIL_DOMAIN}"
