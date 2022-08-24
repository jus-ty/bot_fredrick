aws_region      = "ap-southeast-2"
vpc_cidr_block  = "10.0.0.0/24"
vpc_name_tag    = {"Name": "bot_fredrick_vpc_prod"}
public_subnet_name_tag = {"Name": "bot_fredrick_public_subnet_prod"}
public_subnet_cidr_block = "10.0.0.0/28"
private_subnet_name_tag = {"Name": "bot_fredrick_private_subnet_prod"}
private_subnet_cidr_block = "10.0.0.16/28"
igw_name_tag = {"Name": "bot_fredrick_igw_prod"}
security_group_name_tag = {"Name": "bot_fredrick_sg_prod"}
generic_tags    = {
    "Environment": "prod"
    "Project": "bot_fredrick"
}