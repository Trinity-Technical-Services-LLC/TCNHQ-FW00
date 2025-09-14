provider "opnsense" {
  alias      = "TCNHQ-FW02"
  url        = var.fw02_url
  api_key    = var.fw02_api_key
  api_secret = var.fw02_api_secret
  allow_insecure = true
}
