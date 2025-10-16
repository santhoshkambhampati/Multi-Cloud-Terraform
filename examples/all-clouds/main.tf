terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

# AWS Module
module "aws_resources" {
  source = "../../AWS"

  aws_region    = var.aws_region
  instance_ami  = var.instance_ami
  instance_type = var.instance_type
}

# GCP Module
module "gcp_resources" {
  source = "../../GCP"

  gcp_project           = var.gcp_project
  gcp_region            = var.gcp_region
  instance_machine_type = var.instance_machine_type
  instance_image        = var.instance_image
}

# Azure Module
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
output "aws_instance_ip" {
  description = "Public IP address of the AWS EC2 instance"
  value       = module.aws_resources.aws_instance_ip
}

output "aws_instance_id" {
  description = "ID of the AWS EC2 instance"
  value       = module.aws_resources.aws_instance_id
}

output "gcp_instance_ip" {
  description = "External IP address of the GCP Compute Engine instance"
  value       = module.gcp_resources.gcp_instance_ip
}

output "gcp_instance_id" {
  description = "ID of the GCP Compute Engine instance"
  value       = module.gcp_resources.gcp_instance_id
}

output "azure_vm_public_ip" {
  description = "Public IP address of the Azure VM"
  value       = module.azure_resources.azure_vm_public_ip
}

output "azure_vm_id" {
  description = "ID of the Azure VM"
  value       = module.azure_resources.azure_vm_id
}
