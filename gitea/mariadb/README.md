# Gitea with MariaDB

## How to run it

```bash
HOSTNAME=$(hostname -f)
echo ${HOSTNAME} | grep -s -q "\." || HOSTNAME=$(hostname -I | cut -d " " -f 1)
export HOSTNAME
docker-compose up -d
```

```fish
set -xg HOSTNAME (hostname -f)
echo $HOSTNAME | grep -s -q "\."; or set -xg HOSTNAME (hostname -I | cut -d " " -f 1)
set -xg HOSTNAME
docker-compose up -d
```

- Wait some time for mariadb for initialization
- Run `bash init.sh` on the machine run the docker-compose can init gitea.