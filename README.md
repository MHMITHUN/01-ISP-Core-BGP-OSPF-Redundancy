# ISP Dual-Homed Core Network: Multi-AS BGP Peering & OSPF Failover

[![Live Demo](https://img.shields.io/badge/Demo-Live%20BGP%20NOC%20Console-06b6d4)](https://mhmithun.github.io/01-ISP-Core-BGP-OSPF-Redundancy/)
[![License: MIT](https://img.shields.io/badge/License-MIT-emerald.svg)](LICENSE)
[![Platform: Cisco IOS](https://img.shields.io/badge/Router-Cisco%20IOS%2015.x-blue.svg)](configs/cisco_core_bgp.cfg)
[![MikroTik RouterOS v7](https://img.shields.io/badge/Edge-MikroTik%20v7%20BGP-orange.svg)](configs/mikrotik_edge_bgp.rsc)

Enterprise & ISP Grade multi-homed BGP routing architecture with dual Tier-1 upstream peering (eBGP), internal route distribution (iBGP + OSPF Area 0), route-filtering prefix lists, AS-Path prepending, and sub-second automatic link failover.

---

## 🌐 Live Interactive NOC Simulator (`index.html`)

An interactive browser-based Network Operations Center terminal and dynamic topology map:
- **Interactive Dual-ISP Peering**: Toggle primary upstream ISP (Tier-1 Telco) and secondary upstream ISP to observe live BGP path selection (`AS_PATH`, `LOCAL_PREF`, `MED`).
- **Interactive CLI Terminal**: Execute real commands like `show ip bgp summary`, `show ip route ospf`, `show ip bgp 103.140.0.0/22`, and `traceroute 8.8.8.8`.
- **Packet Flow Animation**: Real-time canvas rendering packet routing changes upon simulated fiber cut.

---

## 🛠️ Key Technical Specifications

1. **Dual Upstream eBGP Peering (AS 65001)**:
   - **Primary Link**: Upstream ISP-A (AS 64512), 1 Gbps link, default route received with `LOCAL_PREF 200`.
   - **Secondary / Backup Link**: Upstream ISP-B (AS 64513), 500 Mbps link, `LOCAL_PREF 100`, configured with 2x AS-Path prepend for outbound traffic engineering.
2. **Internal Core Convergence (OSPFv2)**:
   - Core routers (Core-1, Core-2, Aggregation-1) participating in OSPF Area 0 with MD5 cryptographic authentication.
   - Point-to-point `/30` transit links, tuned Hello (1s) and Dead (4s) intervals for sub-second failure detection.
3. **Prefix Filtering & Bogon Protection**:
   - Outbound prefix-list permitting only owned public allocation (`103.140.18.0/24`).
   - Inbound route-map filtering RFC 1918 private subnets, default Bogons, and overly specific routes (> /24).

---

## 📁 Repository Structure
```
├── configs/
│   ├── cisco_core_bgp.cfg        # Full Cisco 7200 / ASR core BGP & OSPF config
│   ├── mikrotik_edge_bgp.rsc     # MikroTik RouterOS v7 BGP template
│   └── packet_tracer_lab_guide.md# Cisco Packet Tracer reproduction guide
├── index.html                    # Interactive NOC & topology web console
├── LICENSE
└── README.md
```

---

## 🚀 Quick Start & Lab Reproduction

### 1. View Interactive Web Topology
```bash
# Open index.html directly in any browser
python -m http.server 8080
# Visit http://localhost:8080
```

### 2. Deploy Cisco IOS Configuration
Copy `configs/cisco_core_bgp.cfg` into Cisco Packet Tracer or GNS3/EVE-NG router console.

---

## 📄 License & Maintainer
Maintained by **[MD. Mahamudul Hasan](https://github.com/MHMITHUN)**  
- Email: mhmmithun1@gmail.com | Phone: 01560027539  
- GitHub: [@MHMITHUN](https://github.com/MHMITHUN) | LinkedIn: [linkedin.com/in/mahamudul0](https://linkedin.com/in/mahamudul0)  
Released under the [MIT License](LICENSE).

