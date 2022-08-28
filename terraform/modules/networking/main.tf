resource "aws_vpc" "main_vpc" {
  cidr_block    = var.vpc_cidr_block
  tags          = var.vpc_tags
}

# Needs a security group!