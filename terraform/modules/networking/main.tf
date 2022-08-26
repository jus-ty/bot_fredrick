resource "aws_vpc" "main_vpc" {
  cidr_block    = var.vpc_cidr_block
  tags          = var.vpc_tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  tags                    = var.public_subnet_tags
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = "true"
}

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  tags                    = var.private_subnet_tags
  cidr_block              = var.private_subnet_cidr_block
  map_public_ip_on_launch = "false"
}

resource "aws_internet_gateway" "internet_gw" {
  vpc_id  = aws_vpc.main_vpc.id
  tags    = var.internet_gateway_tags
}


resource "aws_route_table" "public_rt" {
  vpc_id        = aws_vpc.main_vpc.id
  tags          = var.public_route_table_tags
  route {
    cidr_block  = "0.0.0.0/0"
    gateway_id  = aws_internet_gateway.internet_gw.id
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id       = aws_subnet.public_subnet.id
  route_table_id  = aws_route_table.public_rt.id
}

resource "aws_eip" "nat" {
  vpc   = true
  tags  = var.eip_tags
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id   = aws_eip.nat.id
  subnet_id       = aws_subnet.public_subnet.id
  depends_on      = [aws_internet_gateway.internet_gw]
  tags            = var.nat_gw_tags
}

resource "aws_route_table" "private_rt" {
  vpc_id            = aws_vpc.main_vpc.id
  tags              = var.private_route_table_tags
  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gw.id
  }
}

resource "aws_route_table_association" "private_rta" {
  subnet_id       = aws_subnet.private_subnet.id
  route_table_id  = aws_route_table.private_rt.id
}

resource "aws_security_group" "bastion_sg" {
  vpc_id          = aws_vpc.main_vpc.id
  description     = "Security group to be used by the bastion host (need to manually add myIP as SSH+RDP ingress rule)"
  tags            = var.bastion_security_group_tags
}

resource "aws_security_group_rule" "bastion_egress_to_private_instance_ssh" {
  type                      = "egress"
  from_port                 = 22
  to_port                   = 22
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.private_instance_sg.id
  description               = "SSH Access from bastion to the private instance"
  security_group_id         = aws_security_group.bastion_sg.id
}

resource "aws_security_group_rule" "bastion_egress_to_private_instance_rdp" {
  type                      = "egress"
  from_port                 = 3389
  to_port                   = 3389
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.private_instance_sg.id
  description               = "RDP Access from bastion to the private instance"
  security_group_id         = aws_security_group.bastion_sg.id
}

resource "aws_security_group" "private_instance_sg" {
  vpc_id              = aws_vpc.main_vpc.id
  description         = "Security group to be used to by the private instance host, allowing ssh ingress/egress everywhere"
  tags                = var.private_instance_security_group_tags

  egress {
    from_port         = 80
    to_port           = 80
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "HTTP Access from the private instance to the internet"
  }

  egress {
    from_port         = 443
    to_port           = 443
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
    description       = "HTTPS Access from the private instance to the internet"
  }
}

resource "aws_security_group_rule" "private_instance_ingress_from_bastion_ssh" {
  type                      = "ingress"
  from_port                 = 22
  to_port                   = 22
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.bastion_sg.id
  description               = "SSH Access from bastion to the private instance"
  security_group_id         = aws_security_group.private_instance_sg.id
}

resource "aws_security_group_rule" "private_instance_ingress_from_bastion_rdp" {
  type                      = "ingress"
  from_port                 = 3389
  to_port                   = 3389
  protocol                  = "tcp"
  source_security_group_id  = aws_security_group.bastion_sg.id
  description               = "RDP Access from bastion to the private instance"
  security_group_id         = aws_security_group.private_instance_sg.id
}