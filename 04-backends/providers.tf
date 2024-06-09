terraform {
  required_version = ">= 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    bucket = "terraform-course-remote-state-backend"
    key    = "04-backends/state.tfstate"
    region = "ap-northeast-3"
    # dynamodb_table = "my-dynamodb-state" # lock state
  }
}

provider "aws" {
  region = "ap-northeast-3"
}