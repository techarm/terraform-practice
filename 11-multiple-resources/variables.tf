# variable "subnet_count" {
#   type    = number
#   default = 2
# }

variable "subnet_config" {
  type = map(object({
    cidr_block = string
  }))

  # Ensure that at least one of the subnets is a valid CIDR block
  validation {
    condition     = alltrue([for value in values(var.subnet_config) : can(cidrnetmask(value.cidr_block))])
    error_message = "At least one of the providerd CIDR blocks is not valid."
  }
}

variable "ec2_instance_count" {
  type    = number
  default = 1
}

variable "ec2_instance_config_list" {
  type = list(object({
    instance_type = string
    ami           = string
    subnet        = optional(string, "default")
  }))

  default = []

  # Ensure that only t2.micro is used
  validation {
    condition     = alltrue([for config in var.ec2_instance_config_list : contains(["t2.micro"], config.instance_type)])
    error_message = "Only t2.micro instance are allowed."
  }

  # Ensure that only ubuntu and nginx is used
  validation {
    condition     = alltrue([for config in var.ec2_instance_config_list : contains(["ubuntu", "nginx"], config.ami)])
    error_message = "Only 'ubuntu' and 'nginx' instance are allowed."
  }
}

variable "ec2_instance_config_map" {
  type = map(object({
    instance_type = string
    ami           = string
    subnet        = optional(string, "default")
  }))

  # Ensure that only t2.micro is used
  validation {
    condition     = alltrue([for value in values(var.ec2_instance_config_map) : contains(["t2.micro"], value.instance_type)])
    error_message = "Only t2.micro instance are allowed."
  }

  # Ensure that only ubuntu and nginx is used
  validation {
    condition     = alltrue([for value in values(var.ec2_instance_config_map) : contains(["ubuntu", "nginx"], value.ami)])
    error_message = "Only 'ubuntu' and 'nginx' instance are allowed."
  }
}
