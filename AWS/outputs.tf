output "aws_instance_ip" {
  description = "Public IP address of the AWS EC2 instance"
  value       = aws_instance.example.public_ip
}
