############################
# VPC
############################

data "aws_vpc" "default" {
  default = true
}

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "project04-rds-modules"
  }
}

resource "aws_subnet" "allowed" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "ap-northeast-3a"

  tags = {
    Name   = "subnet-custom-vpc-1"
    Access = "private"
  }
}

resource "aws_subnet" "allowed2" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-northeast-3c"

  tags = {
    Name   = "subnet-custom-vpc-2"
    Access = "private"
  }
}

# For documentation. Not actively used.
resource "aws_subnet" "not_allowed" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.128.0/24"

  tags = {
    Name   = "subnet-default-vpc"
    Access = "private"
  }
}

############################
# Security Group
############################

# 1. Source security group - From where traffic is allow
# 2. Compliant security group
#   2.1 Security group role
# 3. Non-compliant security group
#   3.1 Security group role

resource "aws_security_group" "source" {
  name        = "source-group"
  description = "Security group from where connections are allowed into the DB"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_security_group" "compliant" {
  name        = "compliant-sg"
  description = "Compliant security group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

resource "aws_security_group" "non_compliant" {
  name        = "non-compliant-group"
  description = "Non-Compliant security group"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.non_compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}
