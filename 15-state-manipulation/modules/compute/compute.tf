
resource "aws_instance" "this" {
  count         = var.instance_count
  ami           = var.instance_ami
  instance_type = "t2.micro"
}
