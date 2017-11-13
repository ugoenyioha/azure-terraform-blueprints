resource "azurerm_virtual_network" "petshop-network" {
  name = "petshop-network"
  address_space = ["10.0.0.0/16"]
  location = "West US 2"
  resource_group_name = "${var.azure_resource_group_name}"

#  subnet {
#    name = "loadbalancers"
#    address_prefix= "10.0.1.0/24"
#  }

#  subnet {
#    name = "backend-servers"
#    address_prefix= "10.0.3.0/24"
#  }

#  subnet {
#    name = "databases"
#    address_prefix = "10.0.4.0/24"
#  }
  tags {
    environment = "staging"
  }
}

