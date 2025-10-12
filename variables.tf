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
