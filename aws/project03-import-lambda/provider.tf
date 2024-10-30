terraform {
  required_version = "~> 1.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-3"
  default_tags {
    tags = {
      ManagedBy = "Terraform"
      Project   = "project03-import-lambda"
    }
  }
}
