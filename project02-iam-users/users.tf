locals {
  users_data = yamldecode(file("${path.module}/user-roles.yaml")).users
}

resource "aws_iam_user" "users" {
  for_each = toset(local.users_data[*].username)
  name     = each.value
}

resource "aws_iam_user_login_profile" "users" {
  for_each        = aws_iam_user.users
  user            = each.value.name
  password_length = 8
  #   password_reset_required = true

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key
    ]
  }
}
