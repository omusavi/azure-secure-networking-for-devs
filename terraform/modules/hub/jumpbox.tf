# Terraform blocks to deploy an azure vm
resource "azurerm_windows_virtual_machine" "jumpbox" {
  name                  = "vm${var.team_name}hub"
  location              = azurerm_resource_group.hub.location
  resource_group_name   = azurerm_resource_group.hub.name
  network_interface_ids = [azurerm_network_interface.jumpbox.id]
  size                  = "Standard_DS1_v2"
  admin_username        = "jumpboxuser"
  admin_password        = "JumpboxPassword123!"

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "windows-11"
    sku       = "win11-23h2-pro"
    version   = "latest"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

resource "azurerm_network_interface" "jumpbox" {
  name                = "nic-vm-${var.team_name}-dev-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.hub_default.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_security_group" "jumpbox" {
  name                = "nsg-jumpbox-${var.team_name}-dev-hub"
  location            = azurerm_resource_group.hub.location
  resource_group_name = azurerm_resource_group.hub.name
}
