#!/bin/bash

set -a -e

[[ $(command -v http) ]] && [[ $(command -v jq) ]] || { echo "http and jq are required"; exit 1; }

THIS_DIR=$(dirname $(readlink -f ${BASH_SOURCE}))
source ${THIS_DIR}/env.sh

if [[ $(id -un) == ${DEMO_USER_NAME} && -f ${HOME}/.ssh/id_rsa.pub ]]; then
    title="$(cat ${HOME}/.ssh/id_rsa.pub | cut -d " " -f 3 | tr -d '\r' | tr -d '\n')"
    ssh_key="$(cat ${HOME}/.ssh/id_rsa.pub)"
else
    title="Vagrant"
    ssh_key="$(curl -sL https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant.pub)"
fi
echo ${title} | grep -s -q -E "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" && email=${title} || email="${DEMO_USER_NAME}@${EMAIL_DOMAIN}"

http -a ${GITEA_ADMIN}:${GITEA_ADMIN_PASSWORD} POST :13000/api/v1/admin/users username=${DEMO_USER_NAME} password=${DEMO_USER_PASSWORD} email=${email}
[[ ${DEMO_USER_IS_ADMIN} -gt 0 ]] && http -a ${GITEA_ADMIN}:${GITEA_ADMIN_PASSWORD} PATCH :13000/api/v1/admin/users/${DEMO_USER_NAME} full_name="${DEMO_USER_NAME}" email=${email} admin:=true
http -a ${DEMO_USER_NAME}:${DEMO_USER_PASSWORD} POST :13000/api/v1/user/keys title="${title}" key="${ssh_key}"

if [[ ${DEMO_USER_IS_ADMIN} -gt 0 ]]; then
    http -a ${GITEA_ADMIN}:${GITEA_ADMIN_PASSWORD} POST :13000/api/v1/admin/users/${DEMO_USER_NAME}/orgs username=${DEMO_ORG_NAME} full_name="Demo Organization" description="Demo Organization"
    ADMIN=${DEMO_USER_NAME}
    ADMIN_PASSWORD=${DEMO_USER_PASSWORD}
else
    http -a ${GITEA_ADMIN}:${GITEA_ADMIN_PASSWORD} POST :13000/api/v1/admin/users/${GITEA_ADMIN}/orgs username=${DEMO_ORG_NAME} full_name="Demo Organization" description="Demo Organization"
    ADMIN=${GITEA_ADMIN}
    ADMIN_PASSWORD=${GITEA_ADMIN_PASSWORD}
fi

teamid=$(http -b -a ${ADMIN}:${ADMIN_PASSWORD} POST :13000/api/v1/orgs/${DEMO_ORG_NAME}/teams name=demo-team permission=write description="Demo Team" | jq .id)
http -a ${ADMIN}:${ADMIN_PASSWORD} PUT :13000/api/v1/teams/${teamid}/members/${DEMO_USER_NAME}

http -a ${ADMIN}:${ADMIN_PASSWORD} POST :13000/api/v1/org/${DEMO_ORG_NAME}/repos name="${DEMO_REPO_NAME}" description=""
http -a ${ADMIN}:${ADMIN_PASSWORD} PUT :13000/api/v1/teams/${teamid}/repos/mcda/${DEMO_REPO_NAME}
