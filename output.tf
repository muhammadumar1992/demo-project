# output "public_ip_address" {
#   value = azurerm_virtual_machine.VM01.
# }

output "resource_group_name" {
  value = azurerm_resource_group.demo-rg.name
}

output "tls_private_key" {
  value     = tls_private_key.secureadmin_ssh.private_key_pem
  sensitive = true
}