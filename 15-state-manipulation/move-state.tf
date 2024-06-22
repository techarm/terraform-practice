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

# resource "aws_instance" "new_list" {
#   count         = 2
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t2.micro"
# }

module "aws_instance" {
  source         = "./modules/compute"
  instance_count = 1
  instance_ami   = data.aws_ami.ubuntu.id
}
