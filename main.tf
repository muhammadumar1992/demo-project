
resource "azurerm_resource_group" "demo-rg" {
  name     = var.resource_group
  location = var.location

 tags = {
    Owner = var.Owner
  }
}

resource "azurerm_virtual_network" "demo-vnet" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group

    depends_on = [
          azurerm_resource_group.demo-rg
        
  ]

  tags = {
    Owner = var.Owner
  }

}

resource "azurerm_subnet" "subnet01" {
  name                 = "subnet01"
  resource_group_name  = var.resource_group
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes

   depends_on = [ azurerm_resource_group.demo-rg, azurerm_virtual_network.demo-vnet]
  
}

# Create public IPs
resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  location            = var.location
  resource_group_name = var.resource_group
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_nsg" {
  name                = "my_nsg"
  location            = var.location
  resource_group_name = var.resource_group

# Note that this rule will allow all external connections from internet to SSH port
    security_rule {
    name                       = "SSH"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "vnet-interface" {
  name                = "vnet-interface"
  location            = var.location
  resource_group_name = var.resource_group

        
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }

}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "my-nsg-assoc" {
  network_interface_id      = azurerm_network_interface.vnet-interface.id
  network_security_group_id = azurerm_network_security_group.my_nsg.id
}

# Create (and display) an SSH key
resource "tls_private_key" "secureadmin_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_virtual_machine" "VM01" {
  name                  = "VM01"
  location              = var.location
  resource_group_name   = var.resource_group
  network_interface_ids = [azurerm_network_interface.vnet-interface.id]
  vm_size               = var.vm_size


  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }


   storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
    os_profile {
    computer_name      = var.computer_name
    admin_username     = var.admin_username
    admin_password = var.admin_password
    }
      
    os_profile_linux_config {
    disable_password_authentication = false
  }

    tags = {
    Owner = var.Owner
    Environment = var.Environment
  }
}

# Create a blob storage account
resource "azurerm_storage_account" "demo1992" {
  name                     = "demo1992"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  depends_on = [
          azurerm_resource_group.demo-rg
      
  ]
}

# Create a blob container
resource "azurerm_storage_container" "containertfstate" {
  name                  = "containertfstate"
  storage_account_name  = azurerm_storage_account.demo1992.name
  container_access_type = "private"
}