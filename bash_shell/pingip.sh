#!/usr/bin/env bash
# Linux ping: explicitly choose a /24 prefix and a small host range.
if (( $# < 1 || $# > 3 )); then
    printf 'Usage: %s IPv4_PREFIX [START [END]] (example: 192.0.2 1 10)\n' "$0" >&2
    exit 2
fi
prefix=$1
first=${2:-1}
last=${3:-10}
if [[ ! $prefix =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ||
      ! $first =~ ^[0-9]{1,3}$ || ! $last =~ ^[0-9]{1,3}$ ]]; then
    printf 'Invalid IPv4 prefix or range.\n' >&2; exit 2
fi
IFS=. read -r -a octets <<< "$prefix"
for octet in "${octets[@]}"; do
    if (( 10#$octet > 255 )); then printf 'Invalid IPv4 prefix.\n' >&2; exit 2; fi
done
prefix="$((10#${octets[0]})).$((10#${octets[1]})).$((10#${octets[2]}))"
first=$((10#$first)); last=$((10#$last))
if (( first < 1 || last > 254 || first > last )); then printf 'Range must satisfy 1 <= START <= END <= 254.\n' >&2; exit 2; fi
command -v ping >/dev/null 2>&1 || { printf 'Required command: ping\n' >&2; exit 1; }
status=0
for ((host = first; host <= last; host++)); do
    address="$prefix.$host"
    if ping -n -c 1 -W 1 "$address" >/dev/null 2>&1; then
        printf '%s REPLY\n' "$address"
    else
        printf '%s NO_REPLY (may be filtered)\n' "$address"
        status=1
    fi
done
exit "$status"
