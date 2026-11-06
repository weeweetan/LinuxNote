#!/usr/bin/env bash
if (( $# > 1 )); then printf 'Usage: %s [YYYYMMDD]\n' "$0" >&2; exit 2; fi
if (( $# )); then target=$1; else read -r -p 'Target date (YYYYMMDD): ' target || exit 2; fi
if [[ ! $target =~ ^[0-9]{8}$ ]]; then printf 'Expected YYYYMMDD.\n' >&2; exit 2; fi
date_command='date'
if command -v gdate >/dev/null 2>&1; then date_command='gdate'; fi
target_epoch=$("$date_command" --date="${target:0:4}-${target:4:2}-${target:6:2}" +%s) || {
    printf 'Invalid date, or GNU date is unavailable.\n' >&2
    exit 2
}
now_epoch=$("$date_command" +%s) || exit 1
seconds=$((target_epoch - now_epoch))
if (( seconds < 0 )); then direction=ago; seconds=$((-seconds)); else direction=remaining; fi
printf '%d days and %d hours %s (elapsed time).\n' "$((seconds / 86400))" "$((seconds % 86400 / 3600))" "$direction"
