#!/bin/bash
# Run this script to make every shell file is valid

THIS_FILE=$(readlink -f "${BASH_SOURCE[0]}")
THIS_DIR=$(dirname "${THIS_FILE}")

[[ $(command -v shellcheck) ]] || { echo "Cannot find shellcheck"; exit 1; }

SHELLCHECK_RESULT="true"
while IFS= read -r -d '' shellfile
do
    shellcheck "${shellfile}" || SHELLCHECK_RESULT="false"
done < <(find "${THIS_DIR}" -iname "*.sh" -print0)

[[ ${SHELLCHECK_RESULT} == true ]] || exit 1
