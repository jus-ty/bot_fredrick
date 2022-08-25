variable "vpc_cidr_block" {
    description = "CIDR range of the VPC"
    type        = string
}

variable "vpc_tags" {
    description = "Tags to set on the VPC"
    type        = map(string)
}

variable "public_subnet_tags" {
    description = "Tags to set on the public Subnet"
    type        = map(string)
}


variable "public_subnet_cidr_block" {
    description = "CIDR range for the public subnet"
    type        = string
}

variable "private_subnet_tags" {
    description = "Tags to set on the private Subnet"
    type        = map(string)
}


variable "private_subnet_cidr_block" {
    description = "CIDR range for the private subnet"
    type        = string
}

variable "internet_gateway_tags" {
    description = "Tags for the internet gateway"
    type        = map(string)
}

variable "bastion_security_group_tags" {
    description = "Tags for the bastion security group"
    type        = map(string)
}

variable "private_instance_security_group_tags" {
    description = "Tags for the private instance security group"
    type        = map(string)
}
