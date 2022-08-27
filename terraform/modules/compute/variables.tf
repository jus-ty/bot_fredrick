#AMI
variable "private_instance_ami" {
    description = "AMI to be used by private instance host"
}

variable "bastion_ami" {
    description = "AMI to be used by bastion host"
}

# Public subnet
variable "public_subnet_id" {
    description = "Public subnet ID"
}

# Private subnet
variable "private_subnet_id" {
    description = "Private subnet ID"
}

# Bastion
variable "bastion_security_group_id" {
    description = "Security Group ID for the bastion server"
}

variable "bastion_tags" {
    description = "Tags for the bastion server"
}

# Private instance
variable "private_instance_security_group_id" {
    description = "Security Group ID for the private instance"
}

variable "private_instance_tags" {
    description = "Tags for the private server"
}