#!/bin/bash

SHADOWSOCKS_LIBEV_VERSION=${SHADOWSOCKS_LIBEV_VERSION:-$(curl -sL "https://api.github.com/repos/shadowsocks/shadowsocks-libev/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')}
SHADOWSOCKS_LIBEV_VERSION=${SHADOWSOCKS_LIBEV_VERSION:-v3.3.4}
KCPTUN_VERSION=${KCPTUN_VERSION:-$(curl -s "https://api.github.com/repos/xtaci/kcptun/tags" | jq -r '.[0].name')}
KCPTUN_VERSION=${KCPTUN_VERSION:-v20200321}

export KCPTUN_VERSION SHADOWSOCKS_LIBEV_VERSION
