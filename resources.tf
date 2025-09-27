resource "proxmox_virtual_environment_network_linux_vlan" "node_vlan" {

  # Create one VLAN interface per Proxmox node as defined in the `proxmox_servers` variable
  for_each = local.proxmox_virtual_environment_network_linux_vlan

  node_name = each.value.node_name
  name      = each.value.name
  autostart = each.value.autostart
  comment   = each.value.comment
  mtu       = each.value.MTU
  addresses = each.value.addresses
  gateway   = each.value.gateway

}
