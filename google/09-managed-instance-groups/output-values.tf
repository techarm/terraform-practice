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
