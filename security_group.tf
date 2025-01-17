resource "aws_security_group" "allow" {
  name        = "allow"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = local.ports
    content {
      description      = "${ingress.value} from VPC"
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = [aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow"
  }
}