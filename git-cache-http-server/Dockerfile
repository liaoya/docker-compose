FROM node:lts-alpine

ARG PORT=8080
RUN apk update \
    && apk add bash git \
    && npm install -g git+https://git@github.com/jonasmalacofilho/git-cache-http-server.git

EXPOSE $PORT
VOLUME /var/cache/git

CMD ["/usr/local/bin/git-cache-http-server" "-c" "/data"]
