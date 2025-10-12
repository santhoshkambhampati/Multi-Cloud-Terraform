output "gcp_instance_ip" {
  description = "External IP address of the GCP Compute Engine instance"
  value       = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}

output "gcp_instance_id" {
  description = "ID of the GCP Compute Engine instance"
  value       = google_compute_instance.example.id
}

output "gcp_instance_name" {
  description = "Name of the GCP Compute Engine instance"
  value       = google_compute_instance.example.name
}

output "gcp_vpc_id" {
  description = "ID of the VPC network"
  value       = google_compute_network.vpc.id
}
