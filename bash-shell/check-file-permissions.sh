#!/usr/bin/env bash
if (( $# > 1 )); then printf 'Usage: %s [PATH]\n' "$0" >&2; exit 2; fi
if (( $# )); then filename=$1; else read -r -p 'Input a filename: ' filename || exit 2; fi
[[ -n $filename ]] || { printf 'A path is required.\n' >&2; exit 2; }
if [[ ! -e $filename && ! -L $filename ]]; then
    printf 'Path does not exist: %s\n' "$filename" >&2
    exit 1
fi
filetype=other
if [[ -L $filename ]]; then filetype='symbolic link'
elif [[ -f $filename ]]; then filetype='regular file'
elif [[ -d $filename ]]; then filetype=directory
fi
permissions=''
[[ -r $filename ]] && permissions+=' readable'
[[ -w $filename ]] && permissions+=' writable'
[[ -x $filename ]] && permissions+=' executable'
printf '%s: %s; current-user access:%s\n' "$filename" "$filetype" "${permissions:- none}"
