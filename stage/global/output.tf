output "petshopPriAccountStorageKey" {
  value = "${azurerm_storage_account.PetshopStorage.primary_access_key}"
  sensitive = true
}

output "petshopSecAccountStorageKey" {
  value = "${azurerm_storage_account.PetshopStorage.secondary_access_key}"
  sensitive = true
}

output "petshopResourceGroupName" {
  value = "${var.azure_resource_group_name}"
}

output "environment_tag" {
  value = "${var.environment_tag}"
}

output "azure_region" {
  value = "${var.azure_region}"
}