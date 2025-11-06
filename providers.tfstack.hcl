required_providers {
  azurerm = {
    source  = "hashicorp/azurerm"
    version = ">= 4.0.0"
  }
}
provider "azurerm" "this" {
  config {
    features {}
    use_cli         = true
    use_oidc        = false
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
    client_id       = var.client_id
    client_secret   = var.client_secret
    oidc_token      = var.identity_token
  }
}