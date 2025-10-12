variable "gcp_project" {
  description = "The ID of your Google Cloud project."
  type        = string

  validation {
    condition     = length(var.gcp_project) > 0
    error_message = "The gcp_project must not be empty. Please provide your GCP project ID."
  }
}

variable "gcp_region" {
  description = "The GCP region where resources will be provisioned."
  type        = string
  default     = "us-central1"

  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.gcp_region))
    error_message = "The gcp_region must be a valid GCP region format (e.g., us-central1)."
  }
}

variable "instance_machine_type" {
  description = "The machine type of the GCP Compute Engine instance."
  type        = string
  default     = "e2-micro"  # Updated to newer generation (e2) and free tier eligible

  validation {
    condition     = can(regex("^[a-z][0-9]-", var.instance_machine_type))
    error_message = "The instance_machine_type must be a valid GCP machine type (e.g., e2-micro, n1-standard-1)."
  }
}

variable "instance_image" {
  description = "The image for the GCP Compute Engine instance."
  type        = string
  default     = "debian-cloud/debian-12"  # Updated to Debian 12 (current stable)

  validation {
    condition     = length(var.instance_image) > 0
    error_message = "The instance_image must not be empty."
  }
}
