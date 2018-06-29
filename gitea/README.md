# Gitea README

## Create Gitea Instance

Your need determine to use sqlite or mariadb at first

If you want host's name or IP

```bash
DOMAIN=$(hostname -f)
echo ${DOMAIN} | grep -s -q "\." || DOMAIN=$(hostname -I | cut -d " " -f 1)
export DOMAIN
docker-compose up -d
```

```fish
set -xg DOMAIN (hostname -f)
echo $DOMAIN | grep -s -q "\."; or set -xg DOMAIN (hostname -I | cut -d " " -f 1)
docker-compose up -d
```

Run `bash init.sh` on the machine run the docker-compose can init gitea.

## Setup other user, group and team

```bash
export DEMO_USER_NAME=$(id -un)
export DEMO_USER_IS_LOCAL=1
export DEMO_USER_IS_ADMIN=1

bash create-demo-env.sh
```

```fish
set -xg DEMO_USER_NAME (id -un)
set -xg DEMO_USER_IS_LOCAL 1
set -xg DEMO_USER_IS_ADMIN 1

bash create-demo-env.sh
```
