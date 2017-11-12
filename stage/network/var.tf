

variable "azure_subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "azure_client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "azure_client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "azure_tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}

variable azure_storage_account_name {}
variable azure_container_name {}
variable azure_state_key {}
variable azure_resource_group_name {}
variable azure_storage_access_key {}
