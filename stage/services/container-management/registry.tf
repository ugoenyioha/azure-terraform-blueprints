resource "azurerm_container_registry" "PetclinicContainerRegistry" {
  name                = "petclinic"
  resource_group_name = "${var.azure_resource_group_name}"
  location            = "westus2"
  admin_enabled       = true
  sku                 = "Standard"
}