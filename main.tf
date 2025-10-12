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
  }

  # Optional: Configure backend for remote state storage
  # Uncomment and configure based on your needs
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "multi-cloud/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

# AWS Module
module "aws_resources" {
  source = "./AWS"

  aws_region    = var.aws_region
  instance_ami  = var.instance_ami
  instance_type = var.instance_type
}

# GCP Module
module "gcp_resources" {
  source = "./GCP"

  gcp_project           = var.gcp_project
  gcp_region            = var.gcp_region
  instance_machine_type = var.instance_machine_type
  instance_image        = var.instance_image
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
