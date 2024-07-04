variable location {
  type        = string
  default     = "Central US"
}

variable resource_group {
  type        = string
  default     = "demo-rg"
}

variable Owner {
  type        = string
  default     = "umar.salah@tkxel.io"
}


variable virtual_network_name {
  type        = string
  default     = "demo-vnet"
}

variable address_space {
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable address_prefixes {
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable computer_name {
  type        = string
  default     = "my-first-terraform-vm"
}

variable admin_username {
  type        = string
  default     = "secureadmin"
}

variable admin_password {
  type        = string
  default     = "Password1234!"
}


variable Environment {
  type        = string
  default     = "demo"
}

variable  vm_size  {
  type        = string
  default     = "Standard_DS1_v2"
}