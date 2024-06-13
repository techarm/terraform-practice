terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.37.0" # =, !=, >=, <=, >, <, ~>

        # version = "~> 5.30.0"
        # version = ">5.1.0, < 5.30.0"
    }
  }
}

# Actively managed by us, by out Terrform project
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# Managed somewhere else, we just want to use in out project
data "aws_s3_bucket" "my_external_bucket" {
    bucket = "not-managed-by-us"
}

variable "bucket_name" {
  type = string
  description = "My variable used to set bucket name"
  default = "my_default_bucket_name"
}

output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

locals {
    # local.local_example
    local_example = "This is a local variable"
}

module "my_module" {
  source = "./module-example"
}