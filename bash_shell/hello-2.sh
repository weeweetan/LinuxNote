#!/usr/bin/env bash
if [[ ${1:-} == hello ]]; then
    printf 'Hello, how are you?\n'
elif [[ -z ${1:-} ]]; then
    printf 'Usage: %s hello\n' "$0" >&2; exit 2
else
    printf 'The accepted argument is hello.\n' >&2; exit 2
fi
