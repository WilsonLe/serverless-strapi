resource "aws_vpc" "serverless-strapi-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "serverless-strapi-vpc"
  }
}

resource "aws_subnet" "serverless-strapi-subnet-1" {
  vpc_id            = aws_vpc.serverless-strapi-vpc.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "serverless-strapi-subnet-1"
  }
}

resource "aws_subnet" "serverless-strapi-subnet-2" {
  vpc_id            = aws_vpc.serverless-strapi-vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "serverless-strapi-subnet-2"
  }
}

resource "aws_internet_gateway" "serverless-strapi-vpc-gateway" {
  vpc_id = aws_vpc.serverless-strapi-vpc.id
  tags = {
    Name = "serverless-strapi-vpc-gateway"
  }
}

resource "aws_security_group" "serverless-strapi-security-group" {
  name        = "serverless-strapi-security-group"
  description = "Allow serverless-strapi-security-group ports"
  vpc_id      = aws_vpc.serverless-strapi-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PostgreSQL from VPC"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["140.141.4.62/32"]
    self        = true
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "serverless-strapi-security-group"
  }
}

resource "aws_route_table" "serverless-strapi-route-table" {
  vpc_id = aws_vpc.serverless-strapi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.serverless-strapi-vpc-gateway.id
  }

  tags = {
    Name = "serverless-strapi-route-table"
  }
}

resource "aws_route_table_association" "serverless-strapi-route-table-assoc-1" {
  subnet_id      = aws_subnet.serverless-strapi-subnet-1.id
  route_table_id = aws_route_table.serverless-strapi-route-table.id
}

resource "aws_route_table_association" "serverless-strapi-route-table-assoc-2" {
  subnet_id      = aws_subnet.serverless-strapi-subnet-2.id
  route_table_id = aws_route_table.serverless-strapi-route-table.id
}

resource "aws_vpc_endpoint" "serverless-strapi-lambda-s3" {
  vpc_id          = aws_vpc.serverless-strapi-vpc.id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = [aws_route_table.serverless-strapi-route-table.id]
  tags = {
    Name = "serverless-strapi-lambda-s3"
  }
}
