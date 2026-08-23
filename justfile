default:
    @just --list

# Format and validate all modules.
check: fmt validate

# Check formatting of all modules.
fmt:
    terraform fmt -check -recursive

# Validate all modules.
validate:
    #!/usr/bin/env sh
    set -e
    for dir in */; do
        if [ -f "$dir/versions.tf" ]; then
            echo "==> $dir"
            (cd "$dir" && terraform init -backend=false -input=false -no-color >/dev/null && terraform validate -no-color)
        fi
    done
