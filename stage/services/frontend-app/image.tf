# this is imported from packer build
resource "azurerm_image" "ps_image" {
  location = "West US 2"
  name = "windows_image"
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"

  tags {
    "environment" = "staging"
  }

  lifecycle {
    prevent_destroy = true
  }
}

