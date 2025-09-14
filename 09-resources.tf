
resource "opnsense_interfaces_vlan" "vlan_100" {

  # Explicitly define the provider to use
  provider = opnsense.TCNHQ-FW02

  # vLan Configuration
  description = "VLAN 100 - Gateway"
  device      = "vlan0.100"
  parent      = "lagg0"
  priority    = "0"
  tag         = "100"

}
