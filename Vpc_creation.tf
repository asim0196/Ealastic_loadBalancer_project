provider "aws" {
  region = "ap-southeast-1"
}
################ VPC ########################
resource "aws_vpc" "VPC" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraformVPC"
  }
}
################ Subnet ######################
resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.VPC.id
  availability_zone = "ap-southeast-1a"
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraformSubnet"
  }
}

################ Subnet 2 ######################
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.VPC.id
  availability_zone = "ap-southeast-1b"
  cidr_block = "192.168.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraformSubnet2"
  }
}
################ IGW ################
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "terraformIGW"
  }
}

############### route table ##########
resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC.id

  route = []

  tags = {
    Name = "terraformRT"
  }
}

############## Routing #########
resource "aws_route" "r" {
  route_table_id         = aws_route_table.RT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.IGW.id
  depends_on             = [aws_internet_gateway.IGW]
}

########### SG ##########
resource "aws_security_group" "SG" {
  name        = "terraformSG"
  description = "httpd_traffic"
  vpc_id      = aws_vpc.VPC.id

  ingress {
    description      = "httpd_traffic"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  tags = {
    Name = "MySGterra"
  }
}

########## subnet association ####
resource "aws_route_table_association" "subnetassociate" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.RT.id
}

########## subnet association 2 ####
resource "aws_route_table_association" "subnetassociate2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT.id
}







