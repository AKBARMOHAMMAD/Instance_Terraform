resource "aws_vpc" "akbar-vpc" {
    cidr_block = var.vpc_cidr_block
    instance_tenancy = "default"

    tags = {
      Name = "Akbar-vpc"
    }
}

resource "aws_subnet" "pub-sub-1" {
  vpc_id = aws_vpc.akbar-vpc.id
  cidr_block = var.subnet1_cidr_block
  map_public_ip_on_launch = true
  depends_on = [
    aws_vpc.akbar-vpc
  ]
  tags = {
    Name = "Pub-sub-1"
  }
}
resource "aws_subnet" "pub-sub-2" {
  vpc_id = aws_vpc.akbar-vpc.id
  cidr_block = var.subnet2_cidr_block
  map_public_ip_on_launch = true
  depends_on = [
    aws_vpc.akbar-vpc
  ]
  tags = {
    Name = "Pub-sub-2"
  }
}

resource "aws_route_table" "route1" {
  vpc_id = aws_vpc.akbar-vpc.id
  tags = {
    Name = "Akbar-RT"
  }
}
resource "aws_route_table_association" "sub1-rt" {
  subnet_id = aws_subnet.pub-sub-1.id
  route_table_id = aws_route_table.route1.id
}
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.akbar-vpc.id
  depends_on = [
    aws_vpc.akbar-vpc
  ]
  tags = {
    Name = "Akbar-IGW"
  }  
}

resource "aws_route" "route" {
  route_table_id = aws_route_table.route1.id
  gateway_id = aws_internet_gateway.IGW.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_security_group" "SG" {
  name = "Security Group"
  description = "Allow web inbound traffic"
  vpc_id = aws_vpc.akbar-vpc.id

  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "tls_private_key" "AKBAR-KEY" {
  algorithm = "RSA"
}

resource "aws_key_pair" "Instance_key" {
  key_name = "AKBAR-KEY"
  public_key = tls_private_key.AKBAR-KEY.public_key_openssh 
}

resource "local_file" "AKBAR-KEY" {
  content = tls_private_key.AKBAR-KEY.private_key_pem
  filename = "AKBAR-KEY.pem"
}
