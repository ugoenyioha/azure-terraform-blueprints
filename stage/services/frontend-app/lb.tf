# README
# https://docs.microsoft.com/en-us/azure/load-balancer/load-balancer-get-started-internet-portal

# You need to create and configure the following objects to deploy a load balancer.
#    Front-end IP configuration - contains public IP addresses for incoming network traffic.
#    Back-end address pool - contains network interfaces (NICs) for the virtual
#                            machines to receive network traffic from the load balancer.
#    Load balancing rules - contains rules mapping a public port on the load balancer to port in
#                           the back-end address pool.
#    Inbound NAT rules - contains rules mapping a public port on the load balancer to a port for a specific
#                         virtual machine in the back-end address pool.
#    Probes - contains health probes used to check availability of
#             virtual machines instances in the back-end address pool.

resource "azurerm_subnet" "frontend-webservers" {
  address_prefix = "10.0.2.0/24"
  name = "frontend-webserver"
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  virtual_network_name = "petshop-network"
}

# frontend ip
resource "azurerm_public_ip" "ps_loadbalancer_public_ip" {
  name                         = "ps-public-ip"
  location                     = "West US 2"
  resource_group_name          = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  public_ip_address_allocation = "dynamic"
  domain_name_label = "petshop"

  tags {
    environment = "staging"
  }
}

# backend address pool
resource "azurerm_lb_backend_address_pool" "ps_backendpool" {
  loadbalancer_id = "${azurerm_lb.ps_loadbalancer.id}"
  name = "ps_backend_pool"
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
}

# a collection of load balancing rules - note the odd way that lb_rule refers to the frontend ip
resource "azurerm_lb_rule" "load_balancer_http_apiserver_rule" {
  resource_group_name            = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  loadbalancer_id                = "${azurerm_lb.ps_loadbalancer.id}"
  name                           = "HTTPApiServerRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 8080
  frontend_ip_configuration_name = "ps-public-ip"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.ps_backendpool.id}"
  probe_id                       = "${azurerm_lb_probe.ps_loadbalancer_probe.id}"
  depends_on                     = ["azurerm_lb_probe.ps_loadbalancer_probe"]
}

resource "azurerm_lb_rule" "load_balancer_http_configserver_rule" {
  resource_group_name            = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  loadbalancer_id                = "${azurerm_lb.ps_loadbalancer.id}"
  name                           = "HTTPConfigServerRule"
  protocol                       = "Tcp"
  frontend_port                  = 8888
  backend_port                   = 8888
  frontend_ip_configuration_name = "ps-public-ip"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.ps_backendpool.id}"
  probe_id                       = "${azurerm_lb_probe.ps_loadbalancer_probe.id}"
  depends_on                     = ["azurerm_lb_probe.ps_loadbalancer_probe"]
}

resource "azurerm_lb_rule" "load_balancer_http_discoveryserver_rule" {
  resource_group_name            = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  loadbalancer_id                = "${azurerm_lb.ps_loadbalancer.id}"
  name                           = "HTTPDiscoveryServerRule"
  protocol                       = "Tcp"
  frontend_port                  = 9411
  backend_port                   = 9411
  frontend_ip_configuration_name = "ps-public-ip"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.ps_backendpool.id}"
  probe_id                       = "${azurerm_lb_probe.ps_loadbalancer_probe.id}"
  depends_on                     = ["azurerm_lb_probe.ps_loadbalancer_probe"]
}

resource "azurerm_lb_rule" "load_balancer_http_adminserver_rule" {
  resource_group_name            = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  loadbalancer_id                = "${azurerm_lb.ps_loadbalancer.id}"
  name                           = "HTTPAdminServerRule"
  protocol                       = "Tcp"
  frontend_port                  = 9090
  backend_port                   = 9090
  frontend_ip_configuration_name = "ps-public-ip"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.ps_backendpool.id}"
  probe_id                       = "${azurerm_lb_probe.ps_loadbalancer_probe.id}"
  depends_on                     = ["azurerm_lb_probe.ps_loadbalancer_probe"]
}

resource "azurerm_lb_probe" "ps_loadbalancer_probe" {
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  loadbalancer_id     = "${azurerm_lb.ps_loadbalancer.id}"
  name                = "RDPProbe"
  protocol            = "tcp"
  port                = 3389
}

# inbound nat rules
resource "azurerm_lb_nat_rule" "rdp_nat" {
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
  loadbalancer_id = "${azurerm_lb.ps_loadbalancer.id}"
  name = "RDP-vm-1"
  protocol = "Tcp"
  frontend_port = "3389"
  backend_port = "3389"
  frontend_ip_configuration_name = "ps-public-ip"
}

# no probes for now - but here's an example
# LB Probe - Checks to see which VMs are healthy and available
//resource "azurerm_lb_probe" "load_balancer_probe" {
//   resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"
//   loadbalancer_id     = "${azurerm_lb.ps_loadbalancer.id}"
//   name                = "tcp"
//   port                = 3389
//}

# Front End Load Balancer
resource "azurerm_lb" "ps_loadbalancer" {
  name                = "ps-loadbalancer"
  location            = "West US 2"
  resource_group_name = "${data.terraform_remote_state.staging.petshopResourceGroupName}"

  frontend_ip_configuration {
    name                 = "ps-public-ip"
    public_ip_address_id = "${azurerm_public_ip.ps_loadbalancer_public_ip.id}"
  }

  tags {
    environment = "staging"
  }
}
