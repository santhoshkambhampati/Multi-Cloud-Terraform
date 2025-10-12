output "aws_instance_ip" {
  description = "Public IP address of the AWS EC2 instance"
  value       = aws_instance.example.public_ip
}

output "aws_instance_id" {
  description = "ID of the AWS EC2 instance"
  value       = aws_instance.example.id
}

output "aws_vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "aws_security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance.id
}
