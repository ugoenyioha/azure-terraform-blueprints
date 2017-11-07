resource "azurerm_network_security_group" "petstore_subnet_securitygroup" {
  location = "westus2"
  name = "petstore_subnet_sg"
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"

  security_rule {
    access = "Allow"
    destination_address_prefix = "*"
    destination_port_range = "8080"
    direction = "Inbound"
    name = "apiServerRule"
    priority = 150
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
  }

  security_rule {
    access = "Allow"
    destination_address_prefix = "*"
    destination_port_range = "8888"
    direction = "Inbound"
    name = "configServerRule"
    priority = 100
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
  }

  security_rule {
    access = "Allow"
    destination_address_prefix = "*"
    destination_port_range = "9411"
    direction = "Inbound"
    name = "discoveryServerRule"
    priority = 110
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
  }

  security_rule {
    access = "Allow"
    destination_address_prefix = "*"
    destination_port_range = "9090"
    direction = "Inbound"
    name = "adminServerRule"
    priority = 115
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
  }

  security_rule {
    access = "Allow"
    destination_address_prefix = "*"
    destination_port_range = "3389"
    direction = "Inbound"
    name = "rdpServiceRule"
    priority = 140
    protocol = "Tcp"
    source_address_prefix = "*"
    source_port_range = "*"
  }
}