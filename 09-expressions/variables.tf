variable "number_list" {
  type = list(number)
}

variable "object_list" {
  type = list(object({
    name = string
    age  = number
  }))
}

variable "number_map" {
  type = map(number)
}

variable "users" {
  type = list(object({
    username = string
    role     = string
  }))
}