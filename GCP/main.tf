terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  # Authentication will use one of the following methods:
  # 1. GOOGLE_APPLICATION_CREDENTIALS environment variable pointing to a service account key file
  # 2. gcloud CLI credentials (gcloud auth application-default login)
  # 3. Service account attached to the compute instance (if running on GCP)
  
  project = var.gcp_project
  region  = var.gcp_region
}

# Create VPC Network
resource "google_compute_network" "vpc" {
  name                    = "terraform-vpc"
  auto_create_subnetworks = false
  description             = "VPC network created by Terraform"
}

# Create Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "terraform-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc.id
  description   = "Subnet created by Terraform"
}

# Create Firewall Rule - Allow SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "terraform-allow-ssh"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-enabled"]
  description   = "Allow SSH from anywhere"
}

# Create Firewall Rule - Allow HTTP
resource "google_compute_firewall" "allow_http" {
  name    = "terraform-allow-http"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-enabled"]
  description   = "Allow HTTP/HTTPS from anywhere"
}

# Create Compute Instance
resource "google_compute_instance" "example" {
  name         = "terraform-instance"
  machine_type = var.instance_machine_type
  zone         = "${var.gcp_region}-a"

  tags = ["ssh-enabled", "http-enabled"]

  boot_disk {
    initialize_params {
      image = var.instance_image
      size  = 10
      type  = "pd-standard"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {
      # Ephemeral external IP
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    enable-oslogin = "TRUE"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    echo "Hello from Terraform on GCP!" > /tmp/hello.txt
  EOF

  labels = {
    environment = "demo"
    managed_by  = "terraform"
  }

  # Allow the instance to be deleted with Terraform
  allow_stopping_for_update = true
}
