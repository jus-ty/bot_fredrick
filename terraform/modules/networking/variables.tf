# VPC
variable "vpc_cidr_block" {
    description     = "CIDR range of the VPC"
    type            = string
}

variable "vpc_tags" {
    description     = "Tags to set on the VPC"
    type            = map(string)
}
