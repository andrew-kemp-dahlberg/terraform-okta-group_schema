# versions.tf
# Version constraints

terraform {
  required_version = "~> 1.5"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.13.1"
    }
  }
}