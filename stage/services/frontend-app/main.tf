provider "azurerm" {
  subscription_id 	= "${var.azure_subscription_id}"
  client_id 		= "${var.azure_client_id}"
  client_secret 	= "${var.azure_client_secret}"
  tenant_id 		= "${var.azure_tenant_id}"
}

terraform {
  backend "azurerm" {}
}

data "terraform_remote_state" "staging" {
  backend = "azure"
  config {
    storage_account_name="${var.azure_storage_account_name}"
    container_name="${var.azure_container_name}"
    key="${var.azure_state_key}"
    resource_group_name="${var.azure_resource_group_name}"
    access_key="${var.azure_storage_access_key}"
  }
}


