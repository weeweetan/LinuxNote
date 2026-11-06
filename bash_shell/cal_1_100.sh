#!/usr/bin/env bash
# Sum 1..N; reject invalid input before entering the loop.
if (( $# > 1 )); then
    printf 'Usage: %s [0..1000000]\n' "$0" >&2
    exit 2
fi
if (( $# )); then num=$1; else read -r -p 'Please input a number: ' num || exit 2; fi
if [[ ! $num =~ ^[0-9]{1,7}$ ]] || (( 10#$num > 1000000 )); then
    printf 'Expected an integer from 0 to 1000000.\n' >&2
    exit 2
fi
num=$((10#$num))
sum=0
for ((i = 1; i <= num; i++)); do
    sum=$((sum + i))
done
printf 'sum(1..%d) = %d\n' "$num" "$sum"
