# VPC
variable "vpc_cidr_block" {
    description     = "CIDR range of the VPC"
    type            = string
}

# Public subnet
variable "public_subnet_tags" {
    description     = "Tags to set on the public Subnet"
    type            = map(string)
}

variable "public_subnet_cidr_block" {
    description     = "CIDR range for the public subnet"
    type            = string
}

variable "eip_tags" {
    description     = "Tags for the elastic IP"
    type            = map(string)
}

variable "public_route_table_tags" {
    description     = "Tags to set on the public route table"
    type            = map(string)
}

# Private subnet
variable "private_subnet_tags" {
    description     = "Tags to set on the private Subnet"
    type            = map(string)
}

variable "private_subnet_cidr_block" {
    description     = "CIDR range for the private subnet"
    type            = string
}

variable "nat_instance_tags" {
    description     = "Tags to set on the nat instance"
    type            = map(string)
}

variable "private_route_table_tags" {
    description     = "Tags to set on the private route table"
    type            = map(string)
}

# Internet gateway
variable "internet_gateway_tags" {
    description     = "Tags for the internet gateway"
    type            = map(string)
}

variable "vpc_tags" {
    description     = "Tags to set on the VPC"
    type            = map(string)
}

# Security group - create_poll
variable "create_poll_lambda_security_group_tags" {
    description     = "Tags to be set on the security group for the create_poll lambda function"
    type            = map(string)
}

# NAT Instance SG
variable "nat_instance_security_group_tags" {
    description     = "Tags to be set on the security group for the nat instance"
    type            = map(string)
}