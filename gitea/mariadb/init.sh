#!/bin/bash

set -a -e

[[ $(command -v http) ]] || { echo "http and jq are required"; exit 1; }

THIS_DIR=$(dirname $(readlink -f ${BASH_SOURCE}))
source ${THIS_DIR}/../env.sh

docker-compose -f ${THIS_DIR}/docker-compose.yml up -d
sleep 30s

http --timeout 120 -f POST :13000/install \
     db_type=MySQL db_host="mariadb:3306" db_user=gitea db_passwd=gitea db_name=gitea \
     app_name="Gitea Repository" repo_root_path="/data/git/repositories" lfs_root_path="" \
     ssl_mode=disable run_user=git \
     domain=${DOMAIN} ssh_port=${SSH_PORT} http_port=3000 app_url="${GITEA_URL}" \
     log_root_path="/data/gitea/log" \
     disable_registration=on require_sign_in_view=on \
     no_reply_address="noreply.org" \
     admin_name=${GITEA_ADMIN} admin_passwd=${GITEA_ADMIN_PASSWORD} admin_confirm_passwd=${GITEA_ADMIN_PASSWORD} admin_email="${GITEA_ADMIN}@${EMAIL_DOMAIN}"
