#!/bin/bash
#shellcheck disable=SC1090

set -aex

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")
#shellcheck disable=SC1090
source "${THIS_DIR}/env.sh"

function print_usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") -h <clean|restart|start|stop> <kcptun|libev>
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
shift $((OPTIND - 1))

if [[ $# -ne 2 ]] || [[ $1 != clean && $1 != restart && $1 != start && $1 != stop ]] || [[ ! -d $2 ]]; then
    print_usage
    exit 1
fi

if [[ -f "$2/env.sh" ]]; then source "$2/env.sh"; fi
if [[ $1 == clean ]]; then
    docker-compose -f "${2}/docker-compose.yml" down -v
    rm -f "${2}/.options"
elif [[ $1 == restart ]]; then
    docker-compose -f "${2}/docker-compose.yml" restart
elif [[ $1 == start ]]; then
    docker-compose -f "${2}/docker-compose.yml" up -d
elif [[ $1 == stop ]]; then
    docker-compose -f "${2}/docker-compose.yml" stop
else
    echo "Unknown opereation"
fi
