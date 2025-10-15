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

  validation {
    condition     = can(regex("^ssh-rsa |^ssh-ed25519 ", var.ssh_public_key))
    error_message = "The ssh_public_key must be a valid SSH public key (starting with 'ssh-rsa' or 'ssh-ed25519')."
  }
}

variable "vm_image_publisher" {
  description = "Publisher of the VM image."
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "Offer of the VM image."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"  # Ubuntu 22.04 LTS
}

variable "vm_image_sku" {
  description = "SKU of the VM image."
  type        = string
  default     = "22_04-lts-gen2"

  validation {
    condition     = length(var.vm_image_sku) > 0
    error_message = "The vm_image_sku must not be empty."
  }
}
