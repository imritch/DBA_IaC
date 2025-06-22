output "public_ip" {
  value = azurerm_windows_virtual_machine.sqlvm.public_ip_address
}
