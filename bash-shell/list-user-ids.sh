#!/usr/bin/env bash
# Local /etc/passwd entries only; this is not a directory-service inventory.
while IFS=: read -r username rest; do
    id -- "$username" || exit 1
done < /etc/passwd
