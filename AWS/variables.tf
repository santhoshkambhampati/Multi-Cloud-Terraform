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
  description = "The ID of the AMI to use for the EC2 instance. Default is Amazon Linux 2023 in us-east-1."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Update this to a current AMI ID for your region

  validation {
    condition     = can(regex("^ami-[a-z0-9]{8,}$", var.instance_ami))
    error_message = "The instance_ami must be a valid AMI ID format (e.g., ami-0c55b159cbfafe1f0)."
  }
}

variable "instance_type" {
  description = "The type of EC2 instance to create."
  type        = string
  default     = "t2.micro"

  validation {
    condition     = can(regex("^[a-z][0-9][a-z]?\\.(nano|micro|small|medium|large|xlarge|[0-9]+xlarge)$", var.instance_type))
    error_message = "The instance_type must be a valid EC2 instance type (e.g., t2.micro, t3.small)."
  }
}
