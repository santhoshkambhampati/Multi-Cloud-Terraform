terraform {
  required_version = ">= 1.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

# GCP Module - Deploy only GCP resources
module "gcp_resources" {
  source = "../../GCP"

  gcp_project           = var.gcp_project
  gcp_region            = var.gcp_region
  instance_machine_type = var.instance_machine_type
  instance_image        = var.instance_image
}

# Outputs
output "gcp_instance_ip" {
  description = "External IP address of the GCP Compute Engine instance"
  value       = module.gcp_resources.gcp_instance_ip
}

output "gcp_instance_id" {
  description = "ID of the GCP Compute Engine instance"
  value       = module.gcp_resources.gcp_instance_id
}

output "gcp_vpc_id" {
  description = "ID of the VPC network"
  value       = module.gcp_resources.gcp_vpc_id
}
