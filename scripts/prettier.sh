#!/usr/bin/env bash

TO_PRETTY=$(npx prettier --list-different '**/*')

set -e

if [ -n "${TO_PRETTY}" ]; then
  prettier --write \
           --ignore-path .prettierignore \
           --config .prettierrc.yml $(tr -s '\n' ' ' <<< "${TO_PRETTY}")
fi

