resource "aws_vpc" "main_vpc" {
  cidr_block = var.cidr_block
  tags = var.tags
}