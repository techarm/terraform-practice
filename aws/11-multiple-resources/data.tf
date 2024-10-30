locals {
  project           = "11-multipple-resources"
  availability_zone = "ap-northeast-3a"
}

data "aws_availability_zones" "available" {
  state = "available"
}

