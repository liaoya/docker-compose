#!/bin/bash

if git rev-parse --show-toplevel 1>/dev/null 2>&1; then
    ROOT_DIR=$(git rev-parse --show-toplevel)
    cat <<'EOF' >"${ROOT_DIR}/.git/hooks/pre-commit"
#!/bin/bash

set -e

echo "Running validations..."
bash ./run-shellcheck.sh .
if [[ -n $(command -v shfmt) && -n $(shfmt -i 4 -d .) ]]; then
    echo "Fail to run shfmt check, stage your change and run \$(shfmt -i 4 -w .)"
    exit 1
fi
EOF

    chmod a+x "${ROOT_DIR}/.git/hooks/pre-commit"
fi
