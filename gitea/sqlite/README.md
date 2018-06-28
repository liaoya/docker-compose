# Gitea with SQLite

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
docker-compose up -d
```

Run `bash init.sh` on the machine run the docker-compose can init gitea.