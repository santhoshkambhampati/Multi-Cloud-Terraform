variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "The ID of the AMI to use for the AWS EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Update this for your region
}

variable "instance_type" {
  description = "The type of AWS EC2 instance to create."
  type        = string
  default     = "t2.micro"
}
