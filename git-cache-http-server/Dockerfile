FROM node:10.15.0-alpine

VOLUME [ "/data" ]

RUN apk add git && \
    npm install -g git+https://git@github.com/jonasmalacofilho/git-cache-http-server.git

CMD ["/usr/local/bin/git-cache-http-server" "-c" "/data"]
