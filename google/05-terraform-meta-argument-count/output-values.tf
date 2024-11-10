output "vm_name_0" {
  description = "VM Name"
  value       = google_compute_instance.myapp[0].name
}

output "vm_name_1" {
  description = "VM Name"
  value       = google_compute_instance.myapp[1].name
}

output "for_output_list" {
  description = "For Loop with List"
  value       = [for instance in google_compute_instance.myapp : instance.name]
}

output "for_output_map1" {
  description = "For Loop with Map"
  value       = { for instance in google_compute_instance.myapp : instance.name => instance.instance_id }
}

output "for_output_map2" {
  description = "For Loop with Map - Advanced1"
  value       = { for index, instance in google_compute_instance.myapp : index => instance.instance_id }
}

output "for_output_map3" {
  description = "For Loop with Map - Advanced2"
  value       = { for index, instance in google_compute_instance.myapp : instance.name => instance.instance_id }
}

# Output Legacy Splat Operator (Legacy) - Returns the List
output "legacy_splat_instance" {
  description = "Legacy Splat Operator"
  value       = google_compute_instance.myapp.*.name
}

# Output Latest Generalized Splat Operator - Returns the List
output "latest_splat_instance" {
  description = "Generalized latest Splat Operator"
  value       = google_compute_instance.myapp[*].name
}
