resource "aws_vpc" "main_vpc" {
  cidr_block                  = var.vpc_cidr_block
  tags                        = var.vpc_tags
}

resource "aws_security_group" "create_poll_lambda_security_group" {
  vpc_id                      = aws_vpc.main_vpc.id
  description                 = "Security group to be used by the create_poll lambda function"
  tags                        = var.create_poll_lambda_security_group_tags

  egress {
    from_port                 = 80
    to_port                   = 80
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]
    description               = "HTTP Access from the lambda to the internet"
  }

  egress {
    from_port                 = 443
    to_port                   = 443
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]
    description               = "HTTPS Access from the lambda to the internet"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                      = aws_vpc.main_vpc.id
  tags                        = var.public_subnet_tags
  cidr_block                  = var.public_subnet_cidr_block
  map_public_ip_on_launch     = "true"
}

resource "aws_subnet" "private_subnet" {
  vpc_id                      = aws_vpc.main_vpc.id
  tags                        = var.private_subnet_tags
  cidr_block                  = var.private_subnet_cidr_block
  map_public_ip_on_launch     = "false"
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id                      = aws_vpc.main_vpc.id
  tags                        = var.internet_gateway_tags
}

resource "aws_route_table" "public_rt" {
  vpc_id                      = aws_vpc.main_vpc.id
  tags                        = var.public_route_table_tags
  route {
    cidr_block                = "0.0.0.0/0"
    gateway_id                = aws_internet_gateway.internet_gw.id
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id                   = aws_subnet.public_subnet.id
  route_table_id              = aws_route_table.public_rt.id
}

resource "aws_eip" "nat_instance" {
  vpc                         = true
  instance                    = aws_instance.nat_instance.id
  tags                        = var.eip_tags
}

resource "aws_instance" "nat_instance" {
  ami                         = "ami-0d142f08d13879a08"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.nat_instance_security_group.id]
  source_dest_check           = false
  subnet_id                   = aws_subnet.public_subnet.id
  depends_on                  = [aws_internet_gateway.internet_gw]
  tags                        = var.nat_instance_tags
}

resource "aws_security_group" "nat_instance_security_group" {
  vpc_id                      = aws_vpc.main_vpc.id
  description                 = "Security group to be used by the nat instance"
  tags                        = var.nat_instance_security_group_tags

  ingress {
    from_port                 = 80
    to_port                   = 80
    protocol                  = "tcp"
    cidr_blocks               = [var.private_subnet_cidr_block]
    description               = "Allow inbound HTTP traffic from servers in the private subnet"
  }

  ingress {
    from_port                 = 443
    to_port                   = 443
    protocol                  = "tcp"
    cidr_blocks               = [var.private_subnet_cidr_block]
    description               = "Allow inbound HTTPS traffic from servers in the private subnet"
  }

  egress {
    from_port                 = 80
    to_port                   = 80
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]
    description               = "Allow outbound HTTP access to the internet"
  }

  egress {
    from_port                 = 443
    to_port                   = 443
    protocol                  = "tcp"
    cidr_blocks               = ["0.0.0.0/0"]
    description               = "Allow outbound HTTPS access to the internet"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id                      = aws_vpc.main_vpc.id
  tags                        = var.private_route_table_tags
  route {
    cidr_block                = "0.0.0.0/0"
    instance_id               = aws_instance.nat_instance.id
  }
}

resource "aws_route_table_association" "private_rta" {
  subnet_id                   = aws_subnet.private_subnet.id
  route_table_id              = aws_route_table.private_rt.id
}
