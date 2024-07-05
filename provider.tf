# provider "azurerm" {
#   features {}

#   subscription_id = var.subscription_id
#   client_id       = var.client_id
#   client_secret   = var.client_secret
#   tenant_id       = var.tenant_id
# }

# variable "subscription_id" {
#   default = "d0db022f-de7d-4804-aa59-9f2e67e84bcb"
# }

# variable "client_id" {
#   default = "74a60322-b4e7-4acb-b095-eaacea1c6908"
# }

# variable "client_secret" {
#   default = "ffn8Q~QmtFfTM-2uv7tVaBalr2Aq1EIhlFlTpaqf"
# }

# variable "tenant_id" {
#   default = "f4b6bd87-67e1-445b-92a9-4b798f58e4d6"
# }

terraform {
  backend "azurerm" {
    resource_group_name = "demo-rg" 
    storage_account_name = "demo1992"
    container_name = "containertfstate"
    key = "path/to/my/key/terraform.tfstate"
  }
}