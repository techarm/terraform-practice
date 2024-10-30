locals {
  name = "山田 太郎"
  age  = 30
  my_object = {
    key1 = "value1"
    key2 = "value2"
  }
}

output "example1" {
  value = startswith(local.name, "山田")
}

output "example2" {
  value = abs(local.age - 50)
}

output "example3" {
  value = {
    string : file("${path.module}/users.yaml"),
    usernames : yamldecode(file("${path.module}/users.yaml")).users[*].name
  }
}

output "example4" {
  value = yamlencode(local.my_object)
}