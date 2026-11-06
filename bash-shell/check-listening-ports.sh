#!/usr/bin/env bash
# A listening port does not prove which application owns it.
if command -v ss >/dev/null 2>&1; then
    sockets=$(ss -H -lnt) || exit 1
elif command -v netstat >/dev/null 2>&1; then
    sockets=$(netstat -lnt) || exit 1
else
    printf 'Required command: ss (iproute2) or netstat (net-tools).\n' >&2
    exit 1
fi
for port in 80 22 25 21; do
    if awk -v wanted="$port" '
        { n = split($4, parts, ":"); if (parts[n] == wanted) found = 1 }
        END { exit !found }
    ' <<< "$sockets"; then
        printf 'TCP/%d is listening\n' "$port"
    else
        printf 'TCP/%d is not listening\n' "$port"
    fi
done
