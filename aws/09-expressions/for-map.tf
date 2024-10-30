locals {
  double_map = { for key, value in var.number_map : upper(key) => "${value}: ${key}" }
}

output "double_map" {
  value = local.double_map
}