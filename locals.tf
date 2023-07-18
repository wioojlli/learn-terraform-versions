locals {
  azs         = ["us-east-1a", "us-east-1b"]
  cidr_blocks = ["172.16.1.0/24", "172.16.2.0/24"]
  ports       = ["80", "443", "22"]
}