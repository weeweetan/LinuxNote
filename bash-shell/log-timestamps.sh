#!/usr/bin/env bash
# Append a finite number of timestamps; never run an accidental infinite loop.
if (( $# > 3 )); then printf 'Usage: %s [COUNT [INTERVAL_SECONDS [LOG_FILE]]]\n' "$0" >&2; exit 2; fi
count=${1:-5}
interval=${2:-1}
log_file=${3:-date.log}
if [[ ! $count =~ ^[0-9]{1,5}$ || ! $interval =~ ^[0-9]{1,4}$ ]] ||
    (( 10#$count < 1 || 10#$count > 10000 || 10#$interval < 1 || 10#$interval > 3600 )); then
    printf 'COUNT must be 1..10000; INTERVAL_SECONDS must be 1..3600.\n' >&2
    exit 2
fi
count=$((10#$count)); interval=$((10#$interval))
for ((i = 0; i < count; i++)); do
    date >> "$log_file" || exit 1
    if (( i + 1 < count )); then sleep "$interval" || exit 1; fi
done
printf 'Appended %d timestamps to %s\n' "$count" "$log_file"
