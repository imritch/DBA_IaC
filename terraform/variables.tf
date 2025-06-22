variable "resource_group_name" {}
variable "location" { default = "eastus" }
variable "vnet_name" { default = "sql-vnet" }
variable "vnet_address_space" { default = "10.0.0.0/16" }
variable "subnet_name" { default = "sql-subnet" }
variable "subnet_address_prefix" { default = "10.0.1.0/24" }
variable "nsg_name" { default = "sql-nsg" }
variable "nic_name" { default = "sql-nic" }
variable "public_ip_name" { default = "sql-pip" }
variable "vm_name" { default = "sql-vm" }
variable "vm_size" { default = "Standard_M32ms" }
variable "admin_username" {}
variable "admin_password" {}
