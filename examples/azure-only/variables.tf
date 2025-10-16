variable "azure_location" {
  description = "The Azure region where resources will be provisioned."
  type        = string
  default     = "East US"
}

variable "vm_size" {
  description = "The size of the Azure Virtual Machine."
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the Azure VM."
  type        = string
  default     = "azureuser"
}

variable "ssh_public_key" {
  description = "SSH public key for the Azure VM."
  type        = string
}

variable "vm_image_publisher" {
  description = "Publisher of the VM image."
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "Offer of the VM image."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vm_image_sku" {
  description = "SKU of the VM image."
  type        = string
  default     = "22_04-lts-gen2"
}
