# Gitea README

## Create Gitea Instance

Your need determine to use sqlite or mariadb at first

- Run `bash run.sh start sqlite` to create gitea instance with sqlite database
- Run `bash run.sh start mariadb` to create gitea instance with mariadb database
- `create-demo-env.sh` to create a addtional demo user, group and repository

## Customeize Gitea

Take a look at `env.sh`, overwrite these values before create gitea instance
Change `/data/gitea/conf/app.ini` and modify `SSH_PORT         = 10022`