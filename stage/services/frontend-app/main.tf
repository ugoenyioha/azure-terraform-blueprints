provider "azurerm" {
  subscription_id = "SUBSCRIPTION_ID"
  client_id       = "CLIENT_ID"
  client_secret   = "CLIENT_SECRET"
  tenant_id       = "TENANT_ID"
}

data "terraform_remote_state" "staging" {
  backend = "azure"
  config {
    storage_account_name="STATE_STORAGE_ACCOUNT"
    container_name="STATE_STORAGE_CONTAINR"
    key="stage.terraform.tfstate"
    resource_group_name="RESOURCE_GROUP"
    access_key="STORAGE_ACCESS_KEY"
  }
}


