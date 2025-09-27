locals {
  proxmox_virtual_environment_network_linux_vlan = merge(
    [
      for server in var.proxmox_servers : {
        for vlan in var.vlans :
        "${server.name}-v${vlan.vlan}" => {

          assign_ip        = try(vlan.assign_ip, false)
          autostart        = try(vlan.autostart, true)
          comment          = try(vlan.comment, "")
          mtu              = try(vlan.assign_ip, false) ? try(v.mtu, 1500) : null
          node             = server.name
          parent_interface = vlan.parent_interface
          vlan_tag         = vlan.vlan
          cidr_prefix      = try(vlan.cidr_prefix, null)

          ip_address = try(vlan.assign_ip, false) ? (
            format("10.%d.%d.%d", server.site_id, vlan.vlan - 100, server.node_id)
          ) : null

          gateway = try(vlan.assign_ip, false) ? (
            format("10.%d.%d.1", server.site_id, vlan.vlan - 100)
          ) : null

        }
      }
    ]...
  )
}
