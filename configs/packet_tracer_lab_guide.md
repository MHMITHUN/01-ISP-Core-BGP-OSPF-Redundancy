# Cisco Packet Tracer Lab Reproduction Guide: Dual-ISP BGP & OSPF

## Topology Overview
- **Core Router**: Cisco 2911 or 7200 Series
- **ISP-A Router**: Upstream Telco (AS 64512)
- **ISP-B Router**: Backup Upstream (AS 64513)
- **Internal Switch**: Cisco Catalyst 3560 / 2960

## Step-by-Step Packet Tracer Verification
1. Open Cisco Packet Tracer 8.x.
2. Interconnect GigabitEthernet interfaces with Serial or Fiber/Copper Cross-over cables.
3. Paste the configuration from `configs/cisco_core_bgp.cfg` into CLI.
4. Execute verification commands:
   ```bash
   ISP-CORE-R01# show ip bgp summary
   ISP-CORE-R01# show ip route bgp
   ISP-CORE-R01# show ip ospf neighbor
   ISP-CORE-R01# traceroute 8.8.8.8
   ```
5. **Failover Test**:
   Shut down `GigabitEthernet0/0` (`shutdown`), observe BGP neighbor state transition to Idle, and verify traffic seamlessly redirects over `GigabitEthernet0/1` (ISP-B) within 3 seconds.

