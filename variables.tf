# ===================================
# AWS Variables
# ===================================

variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1}$", var.aws_region))
    error_message = "The aws_region must be a valid AWS region format (e.g., us-east-1)."
  }
}

variable "instance_ami" {
  description = "The ID of the AMI to use for the AWS EC2 instance. Default is Amazon Linux 2023 in us-east-1."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Update this to a current AMI ID for your region

  validation {
    condition     = can(regex("^ami-[a-z0-9]{8,}$", var.instance_ami))
    error_message = "The instance_ami must be a valid AMI ID format (e.g., ami-0c55b159cbfafe1f0)."
  }
}

variable "instance_type" {
  description = "The type of AWS EC2 instance to create."
  type        = string
  default     = "t2.micro"

  validation {
    condition     = can(regex("^[a-z][0-9][a-z]?\\.(nano|micro|small|medium|large|xlarge|[0-9]+xlarge)$", var.instance_type))
    error_message = "The instance_type must be a valid EC2 instance type (e.g., t2.micro, t3.small)."
  }
}

# ===================================
# GCP Variables
# ===================================

variable "gcp_project" {
  description = "The ID of your Google Cloud project."
  type        = string

  validation {
    condition     = length(var.gcp_project) > 0
    error_message = "The gcp_project must not be empty. Please provide your GCP project ID."
  }
}

variable "gcp_region" {
  description = "The GCP region where resources will be provisioned."
  type        = string
  default     = "us-central1"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.gcp_region))
    error_message = "The gcp_region must be a valid GCP region format (e.g., us-central1)."
  }
}

variable "instance_machine_type" {
  description = "The machine type of the GCP Compute Engine instance."
  type        = string
  default     = "e2-micro"  # Updated to newer generation (e2) and free tier eligible

  validation {
    condition     = can(regex("^[a-z][0-9]-", var.instance_machine_type))
    error_message = "The instance_machine_type must be a valid GCP machine type (e.g., e2-micro, n1-standard-1)."
  }
}

variable "instance_image" {
  description = "The image for the GCP Compute Engine instance."
  type        = string
  default     = "debian-cloud/debian-12"  # Updated to Debian 12 (current stable)

  validation {
    condition     = length(var.instance_image) > 0
    error_message = "The instance_image must not be empty."
  }
}

# ===================================
# Azure Variables
# ===================================

variable "azure_location" {
  description = "The Azure region where resources will be provisioned."
  type        = string
  default     = "East US"

  validation {
    condition     = length(var.azure_location) > 0
    error_message = "The azure_location must not be empty."
  }
}

variable "vm_size" {
  description = "The size of the Azure Virtual Machine."
  type        = string
  default     = "Standard_B1s"  # Free tier eligible (750 hours/month)

  validation {
    condition     = can(regex("^Standard_", var.vm_size))
    error_message = "The vm_size must be a valid Azure VM size (e.g., Standard_B1s, Standard_DS1_v2)."
  }
}

variable "admin_username" {
  description = "Admin username for the Azure VM."
  type        = string
  default     = "azureuser"

  validation {
    condition     = length(var.admin_username) >= 1 && length(var.admin_username) <= 64
    error_message = "The admin_username must be between 1 and 64 characters."
  }
}

variable "ssh_public_key" {
  description = "SSH public key for the Azure VM. Generate with 'ssh-keygen -t rsa -b 4096'."
  type        = string
  default     = ""  # Must be provided by user

  validation {
    condition     = var.ssh_public_key == "" || can(regex("^ssh-rsa |^ssh-ed25519 ", var.ssh_public_key))
    error_message = "The ssh_public_key must be a valid SSH public key (starting with 'ssh-rsa' or 'ssh-ed25519') or empty."
  }
}

variable "vm_image_publisher" {
  description = "Publisher of the Azure VM image."
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "Offer of the Azure VM image."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"  # Ubuntu 22.04 LTS
}

variable "vm_image_sku" {
  description = "SKU of the Azure VM image."
  type        = string
  default     = "22_04-lts-gen2"

  validation {
    condition     = length(var.vm_image_sku) > 0
    error_message = "The vm_image_sku must not be empty."
  }
}
