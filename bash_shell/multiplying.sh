#!/usr/bin/env bash
# Bounds keep the product within a signed 64-bit integer.
if (( $# == 2 )); then
    first=$1
    second=$2
elif (( $# == 0 )); then
    read -r -p 'First integer: ' first || exit 2
    read -r -p 'Second integer: ' second || exit 2
else
    printf 'Usage: %s [INTEGER INTEGER]\n' "$0" >&2
    exit 2
fi
normalize() {
    local value=$1 sign=''
    [[ $value =~ ^-?[0-9]{1,9}$ ]] || return 2
    if [[ $value == -* ]]; then sign=-; value=${value#-}; fi
    printf '%s%d' "$sign" "$((10#$value))"
}
if ! first=$(normalize "$first") || ! second=$(normalize "$second"); then
    printf 'Expected signed integers with at most 9 digits.\n' >&2
    exit 2
fi
printf '%d * %d = %d\n' "$first" "$second" "$((first * second))"
