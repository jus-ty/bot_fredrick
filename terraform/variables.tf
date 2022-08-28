# General
variable "aws_region" {
    description = "The AWS region to create the resource"
    type        = string
}

variable "generic_tags" {
    description = "Generic tags for all resources"
    type        = string
}

# VPC
variable "vpc_cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
}

variable "vpc_name_tag" {
    description = "Name of the VPC"
    type        = map(string)
}

# Public subnet
variable "public_subnet_name_tag" {
    description = "Name of the public subnet"
    type        = map(string)
}

variable "public_subnet_cidr_block" {
    description = "CIDR block for the public subnet"
    type        = string
}

variable "eip_name_tag" {
    description = "Name of the elastic IP"
    type        = map(string)
}

variable "public_route_table_name_tag" {
    description = "Name of the public route table"
    type        = map(string)
}

# Private subnet
variable "private_subnet_name_tag" {
    description = "Name of the private subnet"
    type        = map(string)
}

variable "private_subnet_cidr_block" {
    description = "CIDR block for the private subnet"
    type        = string
}

variable "nat_gw_name_tag" {
    description = "Name of the nat gateway"
    type        = map(string)
}

variable "private_route_table_name_tag" {
    description = "Name of the private route table"
    type        = map(string)
}

# Internet gateway
variable "igw_name_tag" {
    description = "Internet Gateway name tag"
    type        = map(string)
}

# IAM Role
variable "lambda_iam_name_tag" {
    description = "Name of the IAM role for the lambda function"
    type        = map(string)
}

variable "lambda_iam_name_single" {
    description = "Name of the IAM for lambda, not in a list/map"
    type        = string
}

# Security Group
variable "lambda_sg_name_tag" {
    description = "Tag of the name of SG for the lambda function"
    type        = map(string)
}

# Lambda
variable "lambda_name_single" {
    description = "Name of the lambda, not in a list/map"
    type        = string
}

variable "lambda_name_tag" {
    description = "Tag of the lambda function"
    type        = map(string)
}