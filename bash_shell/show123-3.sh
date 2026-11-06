#!/usr/bin/env bash
print_choice() { printf 'Your choice is %s\n' "$1"; }
case ${1:-} in
    one) print_choice 1 ;;
    two) print_choice 2 ;;
    three) print_choice 3 ;;
    *) printf 'Usage: %s {one|two|three}\n' "$0" >&2; exit 2 ;;
esac
