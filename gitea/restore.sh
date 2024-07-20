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
    filename=$1
    volume=${filename:0:${#filename}-22}
    shift
    docker run -it --rm -v "${volume}":/volume -v "${PWD}":/backup alpine sh -c "rm -rf /volume/* /volume/..?* /volume/.[!.]* ; tar -C /volume/ -xjf /backup/${filename}"
done
