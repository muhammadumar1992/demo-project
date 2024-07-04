
# common variables
location = "Central US"
resource_group = "demo-rg"
Owner = "umar.salah@tkxel.io"
Environment = "demo"

#Virtual network variables
virtual_network_name = "demo-vnet"
address_space = "10.0.0.0/16"
address_prefixes = "10.0.1.0/24"


# VM variable
  computer_name  = "my-first-terraform-vm"
  admin_username = "secureadmin"
  admin_password = "Password1234!"

  vm_size        = "Standard_DS1_v2"
