terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

# default provider
provider "aws" {
  region = "ap-northeast-3"
}

# can set alias to use this provider 
provider "aws" {
  region = "ap-northeast-1"
  alias = "ap-northeast"
}

resource "aws_s3_bucket" "ap_northeast-1" {
  bucket = "some-random-bucket-name-1fswr56"
  provider = aws.ap-northeast
}

resource "aws_s3_bucket" "ap_northeast-3" {
  bucket = "some-random-bucket-name-1fswr57"
}