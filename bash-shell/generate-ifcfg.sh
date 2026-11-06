#!/usr/bin/env bash
# Legacy ifcfg example. Print a candidate configuration; never edit /etc.
if (( $# != 4 )); then
    printf 'Usage: %s INTERFACE MAC IPv4 NETMASK > ./ifcfg-example\n' "$0" >&2
    exit 2
fi
interface=$1; mac=$2; address=$3; netmask=$4
if [[ ! $interface =~ ^[[:alnum:]_.:-]{1,15}$ || ! $mac =~ ^([[:xdigit:]]{2}:){5}[[:xdigit:]]{2}$ ]]; then
    printf 'Invalid interface name or MAC address.\n' >&2; exit 2
fi
validate_ipv4() {
    local value=$1 octet
    local -a octets
    [[ $value =~ ^[0-9]{1,3}(\.[0-9]{1,3}){3}$ ]] || return 1
    IFS=. read -r -a octets <<< "$value"
    for octet in "${octets[@]}"; do
        (( 10#$octet <= 255 )) || return 1
        # Avoid ambiguous octal-looking addresses in generated configuration.
        [[ $octet == 0 || $octet != 0* ]] || return 1
    done
}
if ! validate_ipv4 "$address" || ! validate_ipv4 "$netmask"; then printf 'Invalid IPv4 address or netmask.\n' >&2; exit 2; fi
IFS=. read -r -a mask_parts <<< "$netmask"
mask=$(( (mask_parts[0] << 24) | (mask_parts[1] << 16) | (mask_parts[2] << 8) | mask_parts[3] ))
inverse=$(( (~mask) & 4294967295 ))
if (( (inverse & (inverse + 1)) != 0 )); then printf 'Netmask must be contiguous.\n' >&2; exit 2; fi
printf 'DEVICE=%s\nHWADDR=%s\nTYPE=Ethernet\nONBOOT=yes\nNM_CONTROLLED=yes\nBOOTPROTO=none\nIPADDR=%s\nNETMASK=%s\nIPV6INIT=no\nUSERCTL=no\n' "$interface" "$mac" "$address" "$netmask"
