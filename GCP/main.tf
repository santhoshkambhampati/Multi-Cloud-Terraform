provider "google" {
  credentials = file("credentials.json")
  project     = "your-gcp-project-id"
  region      = "us-central1"
}

resource "google_compute_instance" "example" {
  name         = "example-instance"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
}

output "gcp_instance_ip" {
  value = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}
