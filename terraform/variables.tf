# General
variable "aws_region" {
    description = "The AWS region to create the resource"
}

variable "ec2_ami" {
    description = "AMI for the EC2 to use"
}

variable "generic_tags" {
    description = "Generic tags for all resources"
}

# VPC
variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
}

variable "vpc_name_tag" {
    description = "Name of the VPC"
}

variable "private_route_table_name_tag" {
    description = "Name of the private route table"
}

variable "public_route_table_name_tag" {
    description = "Name of the public route table"
}

# Public subnet
variable "public_subnet_name_tag" {
    description = "Name of the subnet"
}

variable "public_subnet_cidr_block" {
    description = "CIDR block for the public subnet"
}

variable "eip_name_tag" {
    description = "Name of the elastic IP"
}

# Private subnet
variable "private_subnet_name_tag" {
    description = "Name of the subnet"
}

variable "private_subnet_cidr_block" {
    description = "CIDR block for the public subnet"
}

variable "nat_gw_name_tag" {
    description = "Name of the nat gateway"
}

# Internet gateway
variable "igw_name_tag" {
    description = "Internet Gateway name tag"
}

# Bastion
variable "bastion_security_group_name_tag" {
    description = "Security group name tag for the bastion server"
}

variable "bastion_name_tag" {
    description = "Name tag for the bastion server"
}

# Private instance
variable "private_instance_security_group_name_tag" {
    description = "Security group name tag for the private instance"
}

variable "private_instance_name_tag" {
    description = "Name tag for the private server"
}