# MIG Outputs Region1
output "region1_myapp_mig_id" {
  value = google_compute_region_instance_group_manager.region1_myapp.id
}

output "region1_myapp_mig_instance_group" {
  value = google_compute_region_instance_group_manager.region1_myapp.instance_group
}

output "region1_myapp_mig_self_link" {
  value = google_compute_region_instance_group_manager.region1_myapp.self_link
}

output "region1_myapp_mig_status" {
  value = google_compute_region_instance_group_manager.region1_myapp.status
}

# MIG Outputs Region2
output "region2_myapp_mig_id" {
  value = google_compute_region_instance_group_manager.region2_myapp.id
}

output "region2_myapp_mig_instance_group" {
  value = google_compute_region_instance_group_manager.region2_myapp.instance_group
}

output "region2_myapp_mig_self_link" {
  value = google_compute_region_instance_group_manager.region2_myapp.self_link
}

output "region2_myapp_mig_status" {
  value = google_compute_region_instance_group_manager.region2_myapp.status
}

# loadbalancer output
output "mylb_static_ip_address" {
  description = "The static IP address of the load balancer."
  value       = google_compute_global_address.mylb.address
}

output "mylb_backend_service_self_link" {
  description = "The self link of the backend service."
  value       = google_compute_backend_service.mylb.self_link
}

output "mylb_url_map_self_link" {
  description = "The self link of the URL map."
  value       = google_compute_url_map.mylb.self_link
}

output "mylb_target_http_proxy_self_link" {
  description = "The self link of the target HTTP proxy."
  value       = google_compute_target_http_proxy.mylb.self_link
}

output "mylb_forwarding_rule_ip_address" {
  description = "The IP address of the forwarding rule."
  value       = google_compute_global_forwarding_rule.mylb.ip_address
}
