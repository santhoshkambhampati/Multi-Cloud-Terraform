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
  default     = "e2-micro"
}

variable "instance_image" {
  description = "The image for the GCP Compute Engine instance."
  type        = string
  default     = "debian-cloud/debian-12"
}
