# https://cloud-images.ubuntu.com/locator/ec2/
# 22.04 LTS amd64: ami-081d950961c4aaf38

resource "aws_instance" "web" {
  ami                         = "ami-05ec75e36218611b4" # Nginx
  associate_public_ip_address = true
  instance_type               = "t2.micro"

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.public_http_traffic.id]
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  tags = merge(local.common_tags, {
    Name : "06-resources-ec2"
  })

  lifecycle {
    # default is destroy_before_create
    create_before_destroy = true
    # ignore_changes = [ tags ]
  }
}

resource "aws_security_group" "public_http_traffic" {
  description = "Security group allow traffic on ports 443 and 80"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.main.id

  tags = merge(local.common_tags, {
    Name : "06-resources-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"

  tags = merge(local.common_tags, {
    Name : "06-resources-http"
  })
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"

  tags = merge(local.common_tags, {
    Name : "06-resources-https"
  })
}