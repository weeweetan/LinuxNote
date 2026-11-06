#!/usr/bin/env bash
read -r -p 'First name: ' firstname || exit 2
read -r -p 'Last name: ' lastname || exit 2
printf 'Your full name is: %s %s\n' "$firstname" "$lastname"
