aws_region      = "ap-southeast-2"
vpc_cidr_block  = "10.0.0.0/24"
vpc_name_tag    = {"Name": "bot_fredrick_vpc_dev"}
public_subnet_name_tag = {"Name": "bot_fredrick_public_subnet_dev"}
public_subnet_cidr_block = "10.0.0.0/28"
private_subnet_name_tag = {"Name": "bot_fredrick_private_subnet_dev"}
private_subnet_cidr_block = "10.0.0.16/28"
igw_name_tag = {"Name": "bot_fredrick_igw_dev"}
security_group_name_tag = {"Name": "bot_fredrick_sg_dev"}
generic_tags    = {
    "Environment": "dev"
    "Project": "bot_fredrick"
}