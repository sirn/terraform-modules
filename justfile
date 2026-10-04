default:
    @just --list

# Check formatting, validate modules, and run mock-provider tests.
check: fmt validate test

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

# Run tests for modules with test suites (Terraform >= 1.7).
test:
    #!/usr/bin/env sh
    set -e
    for dir in */; do
        if [ -d "$dir/tests" ]; then
            echo "==> $dir"
            (cd "$dir" && terraform init -backend=false -input=false -no-color >/dev/null && terraform test -no-color)
        fi
    done
