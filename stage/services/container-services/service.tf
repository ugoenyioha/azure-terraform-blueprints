resource "azurerm_resource_group" "petcliniccluster" {
  location = "westus2"
  name = "petcliniccluster"
}

resource "azurerm_container_service" "petcliniccontainerservice" {
  name                   = "petcliniccontainerservice"
  location               = "westus2"
  resource_group_name = "${azurerm_resource_group.petcliniccluster.name}"
  orchestration_platform = "Kubernetes"

  master_profile {
    count      = 1
    dns_prefix = "petclinickubemaster"
  }

  linux_profile {
    admin_username = "petshop"

    ssh_key {
      key_data = "${var.azure_kube_ssh_pubkey}"
    }
  }

  agent_pool_profile {
    name       = "default"
    count      = 3
    dns_prefix = "acctestagent1"
    vm_size    = "Standard_A0"
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