# General
variable "aws_region" {
    description = "The AWS region to create the resource"
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

# IAM Role
variable "lambda_iam_name_tag" {
    description = "Name of the IAM role for the lambda function"
}

variable "lambda_iam_name_single" {
    description = "Name of the IAM for lambda, not in a list/map"
}

# Security Group
variable "lambda_sg_name_tag" {
    description = "Tag of the name of SG for the lambda function"
}

# Lambda
variable "lambda_name_single" {
    description = "Name of the lambda, not in a list/map"
}

variable "lambda_name_tag" {
    description = "Tag of the lambda function"
}