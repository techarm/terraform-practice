locals {
  user_info_map = { for user in var.users : user.username => user.role... }
}

output "user_info_map" {
  value = local.user_info_map
}