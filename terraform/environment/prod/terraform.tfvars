# General
aws_region                        = "ap-southeast-2"
generic_tags    = {
    "Environment": "prod"
    "Project": "bot_fredrick"
}

# VPC
vpc_cidr_block                  = "10.0.0.0/24"
vpc_name_tag                    = {"Name": "bot_fredrick_vpc_prod"}
public_route_table_name_tag     = {"Name": "bot_fredrick_public_route_table_prod"}
private_route_table_name_tag    = {"Name": "bot_fredrick_private_route_table_prod"}

# Public subnet
public_subnet_name_tag      = {"Name": "bot_fredrick_public_subnet_prod"}
public_subnet_cidr_block    = "10.0.0.0/28"
eip_name_tag                = {"Name": "bot_fredrick_eip_prod"}

# Private subnet
private_subnet_name_tag     = {"Name": "bot_fredrick_private_subnet_prod"}
private_subnet_cidr_block   = "10.0.0.16/28"
nat_gw_name_tag             = {"Name": "bot_fredrick_nat_gw_prod"}

# Internet gateway
igw_name_tag                = {"Name": "bot_fredrick_igw_prod"}

# Security group
lambda_sg_name_tag              = {"Name": "bot_fredrick_sg_lambda_prod"}

# Lambda
lambda_name_single          = "bot_fredrick_lambda_prod"
lambda_name_tag                 = {"Name": "bot_fredrick_lambda_prod"}

# IAM Role
lambda_iam_name_single = "bot_fredrick_iam_role_lambda_prod"
lambda_iam_name_tag             = {"Name": "bot_fredrick_iam_role_lambda_prod"}