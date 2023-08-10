module "aws_resources" {
  source = "./aws"

  aws_region         = var.aws_region
  instance_ami       = var.instance_ami
  instance_type      = var.instance_type
}

module "gcp_resources" {
  source = "./gcp"

  gcp_project             = var.gcp_project
  gcp_region              = var.gcp_region
  instance_machine_type   = var.instance_machine_type
  instance_image          = var.instance_image
}

output "aws_instance_ip" {
  value = module.aws_resources.aws_instance_ip
}

output "gcp_instance_ip" {
  value = module.gcp_resources.gcp_instance_ip
}
