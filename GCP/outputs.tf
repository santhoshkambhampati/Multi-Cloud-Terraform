output "gcp_instance_ip" {
  description = "External IP address of the GCP Compute Engine instance"
  value       = google_compute_instance.example.network_interface[0].access_config[0].nat_ip
}
