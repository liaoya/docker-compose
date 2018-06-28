#!/usr/bin/env bash

[[ $(command -v http) ]] && [[ $(command -v jq) ]] || { echo "http and jq are required"; exit 1; }

DOMAIN=$(hostname -f)
echo ${DOMAIN} | grep -s -q "\." || DOMAIN=$(hostname -I | cut -d " " -f 1)
HTTP_PORT=13000
SSH_PORT=10022
GITEA_URL=http://${DOMAIN}:${HTTP_PORT}/
EMAIL_DOMAIN=$(hostname -f)

http --timeout 120 -f POST :13000/install \
     db_type=SQLite3 db_path=/data/gitea/gitea.db \
     app_name="Gitea Repository" repo_root_path="/data/git/repositories" lfs_root_path="" \
     ssl_mode=disable run_user=git \
     domain=${DOMAIN} ssh_port=${SSH_PORT} http_port=3000 app_url="${GITEA_URL}" \
     log_root_path="/data/gitea/log" \
     disable_registration=on require_sign_in_view=on \
     no_reply_address="noreply.org" \
     admin_name=giteadmin admin_passwd=admin123 admin_confirm_passwd=admin123 admin_email="giteadmin@${EMAIL_DOMAIN}"

http -a giteadmin:admin123 POST :13000/api/v1/admin/users username=demo-user password=gitea email="demo-user@${EMAIL_DOMAIN}"
#http -a giteadmin:admin123 PATCH :13000/api/v1/admin/users/demo-user full_name="Demo User" email="demo-user@${EMAIL_DOMAIN}" admin:=true
http -a demo-user:gitea POST :13000/api/v1/user/keys title="Vagrant" key="$(curl -sL https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub)"

http -a giteadmin:admin123 POST :13000/api/v1/admin/users/giteadmin/orgs username=demo-org full_name="Demo Organization" description="Demo Organization"

teamid=$(http -b -a giteadmin:admin123 POST :13000/api/v1/orgs/demo-org/teams name=demo-team permission=write description="Demo Team" | jq .id)
http -a giteadmin:admin123 PUT :13000/api/v1/teams/${teamid}/members/demo-user

http -a giteadmin:admin123 POST :13000/api/v1/org/demo-org/repos name="demo-repo" description=""
http -a giteadmin:admin123 PUT :13000/api/v1/teams/${teamid}/repos/mcda/demo-repo
