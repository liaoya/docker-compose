#!/bin/bash

set -x

function print_usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") -h volume ...
EOF
}

while getopts ":h" opt; do
    case $opt in
    h)
        print_usage
        exit 0
        ;;
    \?)
        print_usage
        exit 1
        ;;
    esac
done

while (($#)); do
    volume=$1
    shift
    docker run -it --rm -v "${volume}":/volume -v "${PWD}":/backup alpine tar -cjf /backup/"${volume}"-"$(date +%m%d%Y-%H%M)".tar.bz2 -C /volume ./
done
