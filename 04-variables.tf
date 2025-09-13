
#region ------ [ OPNSense FW02 ] -------------------------------------------------------------- #

variable "fw02_url" {
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
