resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "tf-demo-vpc" #vpc的名称
  }
}

resource "aws_subnet" "subnet" {
  count                   = length(local.cidr_blocks)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.cidr_blocks[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true #自动分配公有ipv4地址

  tags = {
    Name = "subnet-${count.index}"
  }
}

data "aws_route_table" "table" {
  vpc_id = aws_vpc.main.id
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "tf-demo-ec2-gw"
  }
}

resource "aws_route" "r" {
  route_table_id         = data.aws_route_table.table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}