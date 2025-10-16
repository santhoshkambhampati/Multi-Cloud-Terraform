terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS Module - Deploy only AWS resources
module "aws_resources" {
  source = "../../AWS"

  aws_region    = var.aws_region
  instance_ami  = var.instance_ami
  instance_type = var.instance_type
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

output "aws_vpc_id" {
  description = "ID of the VPC"
  value       = module.aws_resources.aws_vpc_id
}
