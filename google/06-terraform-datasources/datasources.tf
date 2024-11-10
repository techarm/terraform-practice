data "google_compute_zones" "available" {
  status = "UP"
}

output "compute_zones" {
  description = "List of Compute Zones"
  value       = data.google_compute_zones.available.names
}
