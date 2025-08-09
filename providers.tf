# providers.tf
# Okta provider configuration

provider "okta" {
  org_name       = var.okta_org_name
  base_url       = var.okta_base_url
  client_id      = var.okta_client_id
  private_key_id = var.okta_private_key_id
  private_key    = var.okta_private_key
  scopes         = ["okta.schemas.manage", "okta.schemas.read"]
}