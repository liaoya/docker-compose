# BlueOcean README

## Run

```bash
docker compose run -d --rm --service-ports -u root jenkins
```

```bash
docker run --rm -u root -p 8080:8080 -v jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $HOME:/home jenkinsci/blueocean
```
