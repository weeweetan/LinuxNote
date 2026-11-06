#!/usr/bin/env bash
print_choice() {
    printf 'Your choice is '
    printf '%s\n' "$1" | tr '[:lower:]' '[:upper:]'
}
case ${1:-} in
    one|two|three) print_choice "$1" ;;
    *) printf 'Usage: %s {one|two|three}\n' "$0" >&2; exit 2 ;;
esac
