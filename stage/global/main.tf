provider "azurerm" {
  subscription_id 	= "${var.subscription_id}"
  client_id 		= "${var.client_id}"
  client_secret 	= "${var.client_secret}"
  tenant_id 		= "${var.tenant_id}"
}

terraform {
  backend "azurerm" {}
}

resource "azurerm_resource_group" "PetshopResourceGroup" {
  location = "${var.azure_region}"
  name = "${var.azure_resource_group_name}"

  lifecycle {
    prevent_destroy = true
  }

}

resource "azurerm_storage_account" "PetshopStorage" {
  name = "uapsterraformstorage"
  location = "${var.azure_region}"
  resource_group_name = "${var.azure_resource_group_name}"
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags {
    environment = "staging"
  }

  lifecycle {
    prevent_destroy = true
  }

  enable_blob_encryption = true
  enable_https_traffic_only = true
  account_encryption_source = "Microsoft.Storage"
}

resource "azurerm_storage_container" "PetshopStorageContainer" {
  name                  = "ua-ps-terraform-container"
  resource_group_name   = "${var.azure_resource_group_name}"
  storage_account_name  = "${azurerm_storage_account.PetshopStorage.name}"
  container_access_type = "private"

  lifecycle {
    prevent_destroy = true
  }
}
