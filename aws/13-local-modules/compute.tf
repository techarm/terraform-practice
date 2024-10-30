
locals {
  project_name = "13-local-modules"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Owner is Canoical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "from_map" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  subnet_id         = module.vpc.private_subnets["private_subnet"].subnet_id
  availability_zone = module.vpc.private_subnets["private_subnet"].availability_zone

  tags = {
    Project = local.project_name
    Name    = local.project_name
  }
}
