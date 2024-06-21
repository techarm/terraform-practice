locals {
  allowed_instance_types = ["t3.micro", "t2.micro"]
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

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.this.id
  tags = {
    CostCenter = "test"
  }

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {
    create_before_destroy = true
    precondition {
      condition     = contains(local.allowed_instance_types, var.instance_type)
      error_message = "Invalid instance type: ${var.instance_type}"
    }
    postcondition {
      condition     = self.availability_zone == "ap-northeast-3a"
      error_message = "Expect availability_zone: ap-northeast-3a, but got \"${self.availability_zone}\""
    }
  }
}

// Only Show Warning Message!
check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter != "")
    error_message = "Your AWS Instance does not have a Cost Center tag."
  }
}
