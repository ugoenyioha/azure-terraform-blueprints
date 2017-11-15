resource "azurerm_resource_group" "petshopcluster" {
  location = "westus2"
  name = "petcliniccluster"
}

resource "azurerm_container_service" "test" {
  name                   = "petcliniccluster"
  location               = "westus2"
  resource_group_name = "petcliniccluster"
  orchestration_platform = "Kubernetes"

  master_profile {
    count      = 1
    dns_prefix = "petclinicclustermgmt"
  }

  linux_profile {
    admin_username = "petshop"

    ssh_key {
      key_data = "${var.azure_kube_ssh_pubkey}"
    }
  }

  agent_pool_profile {
    name       = "agentpool"
    count      = 3
    dns_prefix = "petcliniccluster"
    vm_size    = "Standard_DS3_v2_Promo"
  }

  service_principal {
    client_id 		= "${var.azure_client_id}"
    client_secret 	= "${var.azure_client_secret}"
  }

  diagnostics_profile {
    enabled = false
  }

  tags {
    environment = "staging"
  }
}