#!/usr/bin/env bash
set -o pipefail
if (( $# > 1 )); then printf 'Usage: %s [10..10000]\n' "$0" >&2; exit 2; fi
if (( $# )); then scale=$1; else read -r -p 'Decimal places (10-10000, default 10): ' scale || exit 2; fi
scale=${scale:-10}
if [[ ! $scale =~ ^[0-9]{1,5}$ ]] || (( 10#$scale < 10 || 10#$scale > 10000 )); then
    printf 'Expected an integer from 10 to 10000.\n' >&2
    exit 2
fi
command -v bc >/dev/null 2>&1 || { printf 'Required command: bc\n' >&2; exit 1; }
printf 'scale=%d; 4*a(1)\n' "$((10#$scale))" | bc -l
