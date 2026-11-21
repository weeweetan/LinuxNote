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
# Absence is data, not an awk exit status: a parser failure must not look like
# four closed ports. Publish the report only after the whole parse succeeds.
report=$(awk '
    { n = split($4, parts, ":"); listening[parts[n]] = 1 }
    END {
        count = split("80 22 25 21", ports, " ")
        for (i = 1; i <= count; i++)
            printf "TCP/%d is %slistening\n", ports[i], (ports[i] in listening) ? "" : "not "
    }
' <<< "$sockets") || {
    printf 'Failed to parse listening sockets.\n' >&2
    exit 1
}
printf '%s\n' "$report"
