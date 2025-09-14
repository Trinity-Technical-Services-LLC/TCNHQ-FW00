
resource "opnsense_interfaces_vlan" "100" {
  description = "VLAN 100 - Gateway"
  device      = "vlan0.100"
  parent      = "lagg0"
  priority    = "0"
  tagg        = "100"
}
