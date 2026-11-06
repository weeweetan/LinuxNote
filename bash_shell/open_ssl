#!/usr/bin/env bash
set -o pipefail
if (( $# < 1 || $# > 2 )); then printf 'Usage: %s DNS_NAME [PORT]\n' "$0" >&2; exit 2; fi
server=$1
port=${2:-443}
if [[ ! $server =~ ^[[:alnum:]][[:alnum:].-]*$ || ! $port =~ ^[0-9]{1,5}$ ]] ||
    (( 10#$port < 1 || 10#$port > 65535 )); then
    printf 'Invalid DNS name or port.\n' >&2; exit 2
fi
for dependency in timeout openssl; do
    command -v "$dependency" >/dev/null 2>&1 || { printf 'Required command: %s\n' "$dependency" >&2; exit 1; }
done
verify_option=-verify_hostname
if [[ $server =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then verify_option=-verify_ip; fi
timeout 15 openssl s_client -connect "$server:$((10#$port))" -servername "$server" \
    -verify_return_error "$verify_option" "$server" -showcerts < /dev/null |
    openssl x509 -noout -subject -issuer -dates -fingerprint -sha256
