locals {
  name_from_splat  = var.object_list[*].name # Only used in list, map is not working
  map_keys_splat   = keys(var.number_map)
  map_values_splat = values(var.number_map)
}

output "name_from_splat" {
  value = local.name_from_splat
}

output "map_splat" {
  value = {
    keys = local.map_keys_splat,
    values = local.map_values_splat,
  }
}