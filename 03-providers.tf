provider "opnsense" {
  alias      = "TCNHQ-FW02"
  uri        = var.fw02_uri
  api_key    = var.fw02_api_key
  api_secret = var.fw02_api_secret
  allow_insecure = true
}
