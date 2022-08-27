# General
aws_region                        = "ap-southeast-2"
private_instance_ec2_ami          = "ami-0173ba6c241b7aa7f"
bastion_ec2_ami                   = "ami-0300dc03c13eb7660"
generic_tags    = {
    "Environment": "dev"
    "Project": "bot_fredrick"
}

# VPC
vpc_cidr_block                  = "10.0.0.0/24"
vpc_name_tag                    = {"Name": "bot_fredrick_vpc_dev"}
public_route_table_name_tag     = {"Name": "bot_fredrick_public_route_table_dev"}
private_route_table_name_tag    = {"Name": "bot_fredrick_private_route_table_dev"}

# Public subnet
public_subnet_name_tag      = {"Name": "bot_fredrick_public_subnet_dev"}
public_subnet_cidr_block    = "10.0.0.0/28"
eip_name_tag                = {"Name": "bot_fredrick_eip_dev"}

# Private subnet
private_subnet_name_tag     = {"Name": "bot_fredrick_private_subnet_dev"}
private_subnet_cidr_block   = "10.0.0.16/28"
nat_gw_name_tag             = {"Name": "bot_fredrick_nat_gw_dev"}

# Internet gateway
igw_name_tag                = {"Name": "bot_fredrick_igw_dev"}

# Bastion
bastion_security_group_name_tag     = {"Name": "bot_fredrick_bastion_sg_dev"}
bastion_name_tag                    = {"Name": "bot_fredrick_bastion_dev"}
bastion_instance_ec2_type           = "t2.micro"

# Private instance
private_instance_security_group_name_tag    = {"Name": "bot_fredrick_private_instance_sg_dev"}
private_instance_name_tag                   = {"Name": "bot_fredrick_private_instance_dev"}
private_instance_ec2_type                   = "t3.large"