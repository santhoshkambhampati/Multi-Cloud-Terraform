# AWS Variables
variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "The ID of the AMI to use for the AWS EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "The type of AWS EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

# GCP Variables
variable "gcp_project" {
  description = "The ID of your Google Cloud project."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region where resources will be provisioned."
  type        = string
  default     = "us-central1"
}

variable "instance_machine_type" {
  description = "The machine type of the GCP Compute Engine instance."
  type        = string
  default     = "e2-micro"
}

variable "instance_image" {
  description = "The image for the GCP Compute Engine instance."
  type        = string
  default     = "debian-cloud/debian-12"
}

# Azure Variables
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
