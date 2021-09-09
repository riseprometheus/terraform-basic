resource "aws_vpc" "server_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"
  tags = {
    Name = var.vpc_name
  }

}

resource "aws_subnet" "server_public_subnet" {
  vpc_id                  = aws_vpc.server_vpc.id
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = "true"
  cidr_block              = "10.0.1.0/24"

  tags = {
    Name = var.subnet_name
  }

}

resource "aws_internet_gateway" "network_gateway" {
  vpc_id = aws_vpc.server_vpc.id

  tags = {
    Name = var.network_gateway_name
  }
}


resource "aws_route_table" "server_route_table" {
  vpc_id = aws_vpc.server_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.network_gateway.id
  }

  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "subnet_route_association"{
    subnet_id = aws_subnet.server_public_subnet.id
    route_table_id = aws_route_table.server_route_table.id
}

resource "aws_security_group" "ssh-permissions" {
  vpc_id = aws_vpc.server_vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    // update this to dynamically get your local ip address
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}
