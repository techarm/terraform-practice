output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}

output "aws_ami" {
  value = {
    ubuntu = data.aws_ami.ubuntu.id
    nginx  = data.aws_ami.nginx.id
  }
}
