resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name = "${var.basename}-${terraform.workspace}-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.basename}-${terraform.workspace}-igw"
  }
}

resource "aws_subnet" "public" {
  for_each                = { for index, name in var.sn_names : index => name }
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, each.key)
  availability_zone       = data.aws_availability_zones.az.names[each.key % 3]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.basename}-${terraform.workspace}-public-subnet-${each.value}"
  }
}

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.basename}-${terraform.workspace}-rtb"
  }
}

resource "aws_route" "rt" {
  route_table_id         = aws_route_table.rtb.id
  gateway_id             = aws_internet_gateway.igw.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "rta" {
  for_each       = { for index, name in var.sn_names : index => name }
  route_table_id = aws_route_table.rtb.id
  subnet_id      = aws_subnet.public[each.key].id
}


data "aws_availability_zones" "az" {
  state = "available"
}
