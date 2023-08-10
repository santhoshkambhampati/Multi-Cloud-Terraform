# AWS Outputs
output "aws_instance_ip" {
  description = "Public IP address of the AWS EC2 instance"
  value       = module.aws_resources.aws_instance_ip
}

# GCP Outputs
output "gcp_instance_ip" {
  description = "External IP address of the GCP Compute Engine instance"
  value       = module.gcp_resources.gcp_instance_ip
}
