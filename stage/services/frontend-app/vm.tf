resource "azurerm_network_interface" "ps-vm-nic" {
  name                = "petshopni"
  location            = "West US 2"
  resource_group_name="${var.azure_resource_group_name}"
  network_security_group_id = "${azurerm_network_security_group.petstore_subnet_securitygroup.id}"

  ip_configuration {
    name                          = "ps-vm-nic"
    subnet_id                     = "${azurerm_subnet.frontend-webservers.id}"
    private_ip_address_allocation = "dynamic"
    load_balancer_backend_address_pools_ids = ["${azurerm_lb_backend_address_pool.ps_backendpool.id}"]
    load_balancer_inbound_nat_rules_ids = ["${azurerm_lb_nat_rule.rdp_nat.id}"]
  }

  tags {
    environment = "staging"
  }
}

resource "azurerm_virtual_machine" "ps_vm" {
  location = "West US 2"
  name = "petshopvm"
  network_interface_ids = ["${azurerm_network_interface.ps-vm-nic.id}"]
  resource_group_name="${var.azure_resource_group_name}"
  vm_size = "Standard_DS3_v2_Promo"
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    id = "${azurerm_image.ps_image.id}"
  }

  storage_os_disk {
    create_option = "FromImage"
    name = "new_windows"
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"

  }

  os_profile {
    computer_name  = "petshop"
    admin_username = "USERNAME"
    admin_password = "PASSWORD"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent = true
  }
}