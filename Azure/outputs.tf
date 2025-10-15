output "azure_vm_public_ip" {
  description = "Public IP address of the Azure VM"
  value       = azurerm_public_ip.main.ip_address
}

output "azure_vm_id" {
  description = "ID of the Azure VM"
  value       = azurerm_linux_virtual_machine.main.id
}

output "azure_vm_name" {
  description = "Name of the Azure VM"
  value       = azurerm_linux_virtual_machine.main.name
}

output "azure_resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = azurerm_resource_group.main.name
}

output "azure_vnet_id" {
  description = "ID of the Azure Virtual Network"
  value       = azurerm_virtual_network.main.id
}

output "azure_nsg_id" {
  description = "ID of the Network Security Group"
  value       = azurerm_network_security_group.main.id
}
