# General
aws_region      = "ap-southeast-2"
ec2_ami         = "ami-0300dc03c13eb7660"
generic_tags    = {
    "Environment": "dev"
    "Project": "bot_fredrick"
}

# VPC
vpc_cidr_block  = "10.0.0.0/24"
vpc_name_tag    = {"Name": "bot_fredrick_vpc_dev"}

# Public subnet
public_subnet_name_tag      = {"Name": "bot_fredrick_public_subnet_dev"}
public_subnet_cidr_block    = "10.0.0.0/28"

# Private subnet
private_subnet_name_tag     = {"Name": "bot_fredrick_private_subnet_dev"}
private_subnet_cidr_block   = "10.0.0.16/28"

# Internet gateway
igw_name_tag                = {"Name": "bot_fredrick_igw_dev"}

# Bastion
bastion_security_group_name_tag     = {"Name": "bot_fredrick_bastion_sg_dev"}
bastion_name_tag                    = {"Name": "bot_fredrick_bastion_dev"}

# Private instance
private_instance_security_group_name_tag    = {"Name": "bot_fredrick_private_instance_sg_dev"}
private_instance_name_tag                   = {"Name": "bot_fredrick_private_instance_dev"}