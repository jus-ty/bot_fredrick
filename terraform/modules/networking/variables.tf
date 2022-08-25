# VPC
variable "vpc_cidr_block" {
    description     = "CIDR range of the VPC"
    type            = string
}

variable "vpc_tags" {
    description     = "Tags to set on the VPC"
    type            = map(string)
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

# Private subnet
variable "private_subnet_tags" {
    description     = "Tags to set on the private Subnet"
    type            = map(string)
}

variable "private_subnet_cidr_block" {
    description     = "CIDR range for the private subnet"
    type            = string
}

# Internet gateway
variable "internet_gateway_tags" {
    description     = "Tags for the internet gateway"
    type            = map(string)
}

# Bastion
variable "bastion_security_group_tags" {
    description     = "Tags for the bastion security group"
    type            = map(string)
}

# Private instance
variable "private_instance_security_group_tags" {
    description     = "Tags for the private instance security group"
    type            = map(string)
}