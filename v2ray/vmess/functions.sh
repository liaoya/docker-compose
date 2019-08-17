#!/bin/bash

function check_command() {
    local prog
    prog=$1
    if [[ -z $(command -v "${prog}") ]]; then
        echo "${prog} is required"
        exit 1
    fi
}

function check_env() {
    check_command docker
    check_command docker-compose
    check_command jq
}
