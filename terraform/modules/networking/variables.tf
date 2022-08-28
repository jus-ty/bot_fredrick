# VPC
variable "vpc_cidr_block" {
    description     = "CIDR range of the VPC"
    type            = string
}

variable "vpc_tags" {
    description     = "Tags to set on the VPC"
    type            = map(string)
}

# Security group
variable "lambda_security_group_tags" {
    description     = "Tags to be set on the lamdbda function"
    type            = map(string)
}
