# variables.tf
# Input variables - values provided by Spacelift environment variables

variable "okta_org_name" {
  description = "Okta organization name (e.g., 'mycompany' for mycompany.okta.com)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.okta_org_name))
    error_message = "Organization name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "okta_base_url" {
  description = "Okta base URL (okta.com, oktapreview.com, or okta-emea.com)"
  type        = string
  default     = "okta.com"
  
  validation {
    condition     = contains(["okta.com", "oktapreview.com", "okta-emea.com"], var.okta_base_url)
    error_message = "Base URL must be one of: okta.com, oktapreview.com, okta-emea.com"
  }
}

variable "okta_client_id" {
  description = "OAuth 2.0 client ID for Okta API authentication"
  type        = string
  sensitive   = true
}

variable "okta_private_key_id" {
  description = "Private key ID for OAuth 2.0 authentication"
  type        = string
  sensitive   = true
}

variable "okta_private_key" {
  description = "Private key (PEM format) for OAuth 2.0 authentication"
  type        = string
  sensitive   = true
}
