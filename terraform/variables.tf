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
