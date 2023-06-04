locals {
  subnet_count = length(local.regional_azs)
  regional_azs = data.aws_availability_zones.available.names
}

resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "private" {
  count = length(local.regional_azs)
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index )
  availability_zone = element(local.regional_azs, count.index)
}

resource "aws_subnet" "public" {
  count = length(local.regional_azs)
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 5, length(local.regional_azs) + count.index )
  availability_zone = element(local.regional_azs, count.index)
}

resource "aws_eip" "nat_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "this" {
  subnet_id = aws_subnet.public[0].id
  allocation_id = aws_eip.nat_ip.id
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

