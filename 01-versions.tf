terraform {
  required_version = ">= 1.5.0"
  required_providers {
    opnsense = {
      source  = "browningluke/opnsense"
      version = "0.12.0"
    }
  }
}
