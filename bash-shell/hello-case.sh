#!/usr/bin/env bash
case ${1:-} in
    hello) printf 'Hello, how are you?\n' ;;
    '') printf 'Usage: %s hello\n' "$0" >&2; exit 2 ;;
    *) printf 'The accepted argument is hello.\n' >&2; exit 2 ;;
esac
