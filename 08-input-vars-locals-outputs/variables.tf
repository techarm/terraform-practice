variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Size of the EC2 instance to be created. Defaults to 't2.micro'."

  validation {
    # condition = var.ec2_instance_type == "t2.micro" || var.ec2_instance_type == "t3.micro"
    condition     = contains(["t2.micro", "t3.micro"], var.ec2_instance_type)
    error_message = "Only supports t2.micro and t3.micro instance types."
  }
}

variable "ec2_volume_size" {
  type        = number
  default     = 10
  description = "Size of the EBS volume in gigabytes to be attached to the EC2 instance. Defaults to 10GB."
}

variable "ec2_volume_type" {
  type        = string
  default     = "gp3"
  description = "Type of the EBS volume to be created. Defaults to 'gp3' (General Purpose SSD)."
}