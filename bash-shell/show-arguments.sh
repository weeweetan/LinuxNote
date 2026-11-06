#!/usr/bin/env bash
printf 'Script: %s\nArgument count: %d\n' "$0" "$#"
if (( $# < 2 )); then printf 'Please provide at least two arguments.\n' >&2; exit 2; fi
printf 'Each argument:\n'
printf '<%s>\n' "$@"
printf 'First: %s\nSecond: %s\n' "$1" "$2"
