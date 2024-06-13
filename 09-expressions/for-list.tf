locals {
  double_number = [for num in var.number_list : num * 2]
  event_number  = [for num in var.number_list : num if num % 2 == 0]
  names         = [for person in var.object_list : person.name]
  persons       = [for person in var.object_list : "name: ${person.name}, age: ${person.age}"]
}

output "double_numbers" {
  value = {
    double : local.double_number
    event : local.event_number
  }
}

output "person_info" {
  value = {
    names : local.names
    persons : local.persons
  }
}