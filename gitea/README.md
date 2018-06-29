# Gitea README

## Create Gitea Instance

Your need determine to use sqlite or mariadb at first

- Run `bash sqlite/init.sh` to create gitea instance with sqlite database
- Run `bash mariadb/init.sh` to create gitea instance with mariadb database

Run `bash create-demo-env.sh` to create a addtional demo user, group and repository

## Customeize Gitea

Take a look at `env.sh`, overwrite these values before create gitea instance
