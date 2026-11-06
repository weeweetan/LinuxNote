#!/usr/bin/env bash
if (( $# > 1 )); then printf 'Usage: %s [PREFIX]\n' "$0" >&2; exit 2; fi
if (( $# )); then prefix=$1; else read -r -p 'Filename prefix (default filename): ' prefix || exit 2; fi
prefix=${prefix:-filename}
date_command='date'
if command -v gdate >/dev/null 2>&1; then date_command='gdate'; fi
# Resolve all dates before creating any files.
dates=()
for offset in 2 1 0; do
    value=$("$date_command" --date="$offset days ago" +%Y%m%d) || {
        printf 'This example requires GNU date (or gdate).\n' >&2
        exit 1
    }
    dates+=("$value")
done
for value in "${dates[@]}"; do
    touch -- "${prefix}${value}" || exit 1
    printf '%s\n' "${prefix}${value}"
done
