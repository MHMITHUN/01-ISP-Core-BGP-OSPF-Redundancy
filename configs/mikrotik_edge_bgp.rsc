# ==============================================================================
# MikroTik RouterOS v7 BGP Edge & Multi-homed Configuration
# Device: MikroTik CCR2004-16G-2S+
# Author: Md. Mahamudul Hasan (Support Engineer - ISP Software & Networking)
# ==============================================================================

/system identity set name="AsianNet-MikroTik-Edge-CCR"

# Public IP Assignment
/ip address
add address=103.140.18.1/24 interface=bridge-lan network=103.140.18.0 comment="Public Allocated Subnet"
add address=203.0.113.2/30 interface=sfp-sfpplus1 network=203.0.113.0 comment="Uplink ISP-A"
add address=198.51.100.2/30 interface=sfp-sfpplus2 network=198.51.100.0 comment="Uplink ISP-B"

# Routing Filters (v7 Routing Rules)
/routing filter rule
add chain=BGP-OUT rule="if (dst == 103.140.18.0/24) { accept; } else { reject; }"
add chain=BGP-IN-A rule="if (dst == 0.0.0.0/0) { set bgp-local-pref 200; accept; } else { reject; }"
add chain=BGP-IN-B rule="if (dst == 0.0.0.0/0) { set bgp-local-pref 100; accept; } else { reject; }"
add chain=BGP-OUT-B rule="if (dst == 103.140.18.0/24) { set bgp-path-prepend 2; accept; } else { reject; }"

# BGP Autonomous System & Instance
/routing bgp template
add as=65001 name=default-template router-id=103.140.18.1

# BGP Connections (eBGP Upstreams)
/routing bgp connection
add address-families=ip as=65001 input.filter=BGP-IN-A name=BGP-ISP-A output.filter-chain=BGP-OUT remote.address=203.0.113.1 .as=64512 templates=default-template
add address-families=ip as=65001 input.filter=BGP-IN-B name=BGP-ISP-B output.filter-chain=BGP-OUT-B remote.address=198.51.100.1 .as=64513 templates=default-template

# Fast Failover / BFD (Bidirectional Forwarding Detection)
/routing bfd configuration
add min-rx=200ms min-tx=200ms multiplier=5 name=bfd-fast-failover

