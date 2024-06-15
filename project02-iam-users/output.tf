output "users_data" {
  value = local.users_map
}

// 本番環境はパスワードをコンソールに表示しないでください！！
output "user_passwords" {
  value = { for user, user_login in aws_iam_user_login_profile.users : user => user_login.password }
}

output "role_policies_list" {
  value = local.role_policies_list
}
