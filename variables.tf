
#region ------ [ OPNSense FW02 ] -------------------------------------------------------------- #

variable "fw02_uri" {
  type        = string
  sensitive   = true
  description = "Base URL for the OPNsense FW02 API"
}

variable "fw02_api_key"    {
  type      = string
  sensitive = true
  description = "API Key for the OPNsense FW02"
}

variable "fw02_api_secret" {
  type      = string
  sensitive = true
  description = "API Secret for the OPNsense FW02"
}

#endregion --- [ OPNSense FW02 ] -------------------------------------------------------------- #

#region ------ [ Proxmox Nodes ] -------------------------------------------------------------- #

variable "proxmox_servers" {

  description = "Map of Proxmox nodes and their network/role settings."

  type = list(object({
    hostname        = string
  }))
}

#endregion --- [ Proxmox Nodes ] -------------------------------------------------------------- #

#region ------ [ Virtual Lans (vLans) ] ------------------------------------------------------- #

variable "vlans" {
  description = "Map of VLAN configurations"
  type = map(object({
    assign_ip        = optional(bool)    # when true, cidr_prefix is required
    autostart        = optional(bool)
    comment          = optional(string)
    mtu              = optional(number)  # validated only if set
    parent_interface = string
    vlan             = number
    cidr_prefix      = optional(number)  # required 1..32 when assign_ip = true
  }))

  # 0) at least one VLAN
  validation {
    condition     = length(var.vlans) > 0
    error_message = "vlans must contain at least one entry."
  }

  # 1) unique VLAN IDs
  validation {
    condition = (
      length(toset([for _, v in var.vlans : v.vlan])) ==
      length([for _, v in var.vlans : v.vlan])
    )
    error_message = "Each VLAN entry must have a unique vlan id."
  }

  # 2) VLAN tag 1..4094
  validation {
    condition = alltrue([ for _, v in var.vlans : v.vlan >= 1 && v.vlan <= 4094 ])
    error_message = "vlan must be between 1 and 4094."
  }

  # 3) MTU valid ONLY if provided
  validation {
    condition = alltrue([
      for _, v in var.vlans :
      v.mtu == null || (floor(v.mtu) == v.mtu && v.mtu >= 576 && v.mtu <= 9216)
    ])
    error_message = "If mtu is set, it must be an integer between 576 and 9216."
  }

  # 4) parent_interface sane
  validation {
    condition = alltrue([
      for _, v in var.vlans :
      length(v.parent_interface) > 0 && can(regex("^[-_.:A-Za-z0-9]+$", v.parent_interface))
    ])
    error_message = "parent_interface must be non-empty and contain only letters, numbers, and -_.: characters."
  }

  # 5) comment length (only enforced if set)
  validation {
    condition = alltrue([ for _, v in var.vlans : length(try(v.comment, "")) <= 256 ])
    error_message = "comment must be 256 characters or fewer."
  }

  # 6) If assign_ip = true, require cidr_prefix ∈ 1..32 (integer)
  validation {
    condition = alltrue([
      for _, v in var.vlans :
      (try(v.assign_ip, false) == false) ||
      (
        v.cidr_prefix != null &&
        floor(v.cidr_prefix) == v.cidr_prefix &&
        v.cidr_prefix >= 1 && v.cidr_prefix <= 32
      )
    ])
    error_message = "When assign_ip is true, cidr_prefix must be an integer between 1 and 32."
  }
}



#endregion --- [ Virtual Lans (vLans) ] ------------------------------------------------------- #
