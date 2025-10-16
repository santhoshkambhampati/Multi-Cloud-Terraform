terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# Azure Module - Deploy only Azure resources
module "azure_resources" {
  source = "../../Azure"

  azure_location     = var.azure_location
  vm_size            = var.vm_size
  admin_username     = var.admin_username
  ssh_public_key     = var.ssh_public_key
  vm_image_publisher = var.vm_image_publisher
  vm_image_offer     = var.vm_image_offer
  vm_image_sku       = var.vm_image_sku
}

# Outputs
output "azure_vm_public_ip" {
  description = "Public IP address of the Azure VM"
  value       = module.azure_resources.azure_vm_public_ip
}

output "azure_vm_id" {
  description = "ID of the Azure VM"
  value       = module.azure_resources.azure_vm_id
}

output "azure_resource_group_name" {
  description = "Name of the Azure Resource Group"
  value       = module.azure_resources.azure_resource_group_name
}
