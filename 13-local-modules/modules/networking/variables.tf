variable "vpc_config" {
  type = object({
    name       = string
    cidr_block = string
  })

  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}

variable "subnet_config" {
  type = map(object({
    cidr_block = string
    az         = string
  }))

  validation {
    condition = alltrue([
      for config in var.subnet_config : can(cidrnetmask(config.cidr_block))
    ])
    error_message = "The cidr_block config option must contain a valid CIDR block."
  }
}
