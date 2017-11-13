resource "azurerm_resource_group" "petcliniccluster" {
  location = "westus2"
  name = "petcliniccluster"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_container_service" "test" {
  name                   = "petcliniccluster"
  location               = "westus2"
  resource_group_name = "petcliniccluster"
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
    vm_size    = "Standard DS2 v2"
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