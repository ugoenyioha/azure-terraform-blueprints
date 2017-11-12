variable "azure_resource_group_name" {
  description = "Resource Group Name"
  default = "petshopresourcegroup"
}

variable "environment_tag" {
  description = "Environment Tag"
  default = "staging"
}

variable "azure_region" {
  description = "where to create resources"
  default = "westus2"
}

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
}
