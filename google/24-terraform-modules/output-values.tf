output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.network_id
}

output "subnet_id" {
  description = "Subnet ID"
  value       = module.vpc.subnets_ids[0]
}

output "vm_external_ip" {
  description = "VM External IPs"
  value       = google_compute_instance.myapp.network_interface.0.access_config.0.nat_ip
}
