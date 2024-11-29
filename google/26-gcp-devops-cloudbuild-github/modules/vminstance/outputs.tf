output "vm_external_ip" {
  description = "VM External IPs"
  value       = google_compute_instance.vminstance.network_interface.0.access_config.0.nat_ip
}
