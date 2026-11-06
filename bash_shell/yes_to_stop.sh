#!/usr/bin/env bash
while read -r -p 'Please input yes/YES to stop: ' answer; do
    case "$answer" in
        yes|YES) printf 'OK.\n'; exit 0 ;;
    esac
done
printf 'Input ended before confirmation.\n' >&2
exit 1
