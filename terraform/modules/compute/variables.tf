variable "instance_ami" {
    description = "AMI to be used by EC2 hosts"
}

variable "public_subnet_id" {
    description = "Public subnet ID"
}

variable "private_subnet_id" {
    description = "Private subnet ID"
}

variable "security_group_id" {
    description = "Security Group ID"
}

variable "bastion_tags" {
    description = "Tags for the bastion server"
}

variable "private_instance_tags" {
    description = "Tags for the private server"
}