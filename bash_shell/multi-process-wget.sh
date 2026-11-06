#!/usr/bin/env bash
if (( $# < 1 || $# > 4 )); then
    printf 'Usage: %s URL [COUNT [CONCURRENCY [OUTPUT_DIRECTORY]]]\n' "$0" >&2; exit 2
fi
url=$1
count=${2:-1}
concurrency=${3:-4}
output_directory=${4:-downloads}
if [[ ! $url =~ ^https?://[^[:space:]]+$ || ! $count =~ ^[0-9]{1,4}$ || ! $concurrency =~ ^[0-9]{1,2}$ ]] ||
    (( 10#$count < 1 || 10#$count > 1000 || 10#$concurrency < 1 || 10#$concurrency > 16 )); then
    printf 'Expected HTTP(S) URL, COUNT 1..1000 and CONCURRENCY 1..16.\n' >&2; exit 2
fi
command -v wget >/dev/null 2>&1 || { printf 'Required command: wget\n' >&2; exit 1; }
count=$((10#$count)); concurrency=$((10#$concurrency))
if [[ $output_directory != /* ]]; then output_directory="./$output_directory"; fi
mkdir -p -- "$output_directory" || exit 1
run_directory=$(mktemp -d "${output_directory%/}/download.XXXXXX") || exit 1
printf 'Output directory: %s\n' "$run_directory"
pids=()
status=0
# Called by the EXIT trap, including INT/TERM exits; covered by the termination test.
# shellcheck disable=SC2329
cleanup() {
    local pid
    for pid in "${pids[@]}"; do kill "$pid" 2>/dev/null || true; done
    for pid in "${pids[@]}"; do wait "$pid" 2>/dev/null || true; done
}
trap cleanup EXIT
trap 'exit 130' INT
trap 'exit 143' TERM
wait_batch() {
    local pid
    for pid in "${pids[@]}"; do
        if ! wait "$pid"; then status=1; fi
    done
    pids=()
}
for ((i = 1; i <= count; i++)); do
    wget --quiet --timeout=20 --tries=1 --limit-rate=100k \
        --output-document="$run_directory/$i.download" -- "$url" &
    pids+=("$!")
    if (( ${#pids[@]} >= concurrency )); then wait_batch; fi
done
wait_batch
if (( status )); then printf 'At least one download failed; partial files remain in %s\n' "$run_directory" >&2; fi
exit "$status"
