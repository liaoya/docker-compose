FROM node:lts-alpine

RUN apk update \
    && apk add bash git \
    && npm install -g git+https://git@github.com/jonasmalacofilho/git-cache-http-server.git

EXPOSE 8080
VOLUME /var/cache/git

CMD ["/usr/local/bin/git-cache-http-server" "-c" "/data"]
