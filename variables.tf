# AWS Variables
variable "aws_region" {
  description = "The AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "instance_ami" {
  description = "The ID of the AMI to use for the AWS EC2 instance."
  type        = string
  default     = "ami-0c55b159cbfafe1f0"
}

variable "instance_type" {
  description = "The type of AWS EC2 instance to create."
  type        = string
  default     = "t2.micro"
}

# GCP Variables
variable "gcp_project" {
  description = "The ID of your Google Cloud project."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region where resources will be provisioned."
  type        = string
  default     = "us-central1"
}

variable "instance_machine_type" {
  description = "The machine type of the GCP Compute Engine instance."
  type        = string
  default     = "n1-standard-1"
}

variable "instance_image" {
  description = "The image for the GCP Compute Engine instance."
  type        = string
  default     = "debian-cloud/debian-9"
}
