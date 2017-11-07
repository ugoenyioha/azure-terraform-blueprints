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