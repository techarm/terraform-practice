# My APP1
output "myapp_mig_id" {
  value = google_compute_region_instance_group_manager.myapp.id
}

output "myapp_mig_instance_group" {
  value = google_compute_region_instance_group_manager.myapp.instance_group
}

output "myapp_mig_self_link" {
  value = google_compute_region_instance_group_manager.myapp.self_link
}

output "myapp_mig_status" {
  value = google_compute_region_instance_group_manager.myapp.status
}

# My APP2
output "myapp2_mig_id" {
  value = google_compute_region_instance_group_manager.myapp2.id
}

output "myapp2_mig_instance_group" {
  value = google_compute_region_instance_group_manager.myapp2.instance_group
}

output "myapp2_mig_self_link" {
  value = google_compute_region_instance_group_manager.myapp2.self_link
}

output "myapp2_mig_status" {
  value = google_compute_region_instance_group_manager.myapp2.status
}

# loadbalancer output
output "mylb_static_ip_address" {
  description = "The static IP address of the load balancer."
  value       = google_compute_address.mylb.address
}

output "mylb_backend_service_self_link" {
  description = "The self link of the backend service."
  value       = google_compute_region_backend_service.myapp.self_link
}

output "myapp2_backend_service_self_link" {
  description = "The self link of the backend service."
  value       = google_compute_region_backend_service.myapp2.self_link
}

output "mylb_url_map_self_link" {
  description = "The self link of the URL map."
  value       = google_compute_region_url_map.mylb.self_link
}

output "mylb_target_http_proxy_self_link" {
  description = "The self link of the target HTTP proxy."
  value       = google_compute_region_target_http_proxy.mylb.self_link
}

output "mylb_forwarding_rule_ip_address" {
  description = "The IP address of the forwarding rule."
  value       = google_compute_forwarding_rule.mylb.ip_address
}
