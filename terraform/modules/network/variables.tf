variable "cidr_block" {
    description = "CIDR range of the VPC"
    type        = string
}

variable "tags" {
    description = "Tags to set on the resource"
    type        = map(string)
}