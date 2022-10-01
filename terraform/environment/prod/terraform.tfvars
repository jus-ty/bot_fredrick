# General
aws_region                          = "ap-southeast-2"
logical_environment                 = "prod"
generic_tags    = {
    "Environment": "prod"
    "Project": "bot_fredrick"
}

# VPC
vpc_name_tag                        = {"Name": "bot_fredrick_vpc_prod"}

# Public subnet
public_subnet_name_tag              = {"Name": "bot_fredrick_public_subnet_prod"}
eip_name_tag                        = {"Name": "bot_fredrick_eip_prod"}
public_route_table_name_tag         = {"Name": "bot_fredrick_public_route_table_prod"}

# Private subnet
private_subnet_name_tag             = {"Name": "bot_fredrick_private_subnet_prod"}
nat_gw_name_tag                     = {"Name": "bot_fredrick_nat_gw_prod"}
private_route_table_name_tag        = {"Name": "bot_fredrick_private_route_table_prod"}

# Internet gateway
igw_name_tag                        = {"Name": "bot_fredrick_igw_prod"}

# Security group
lambda_sg_name_tag                  = {"Name": "bot_fredrick_sg_lambda_prod"}

# Lambda
lambda_name_single                  = "bot_fredrick_lambda_prod"
lambda_name_tag                     = {"Name": "bot_fredrick_lambda_prod"}

# IAM Role
lambda_iam_name_single              = "bot_fredrick_iam_role_lambda_prod"
lambda_iam_name_tag                 = {"Name": "bot_fredrick_iam_role_lambda_prod"}

# Event Bridge
event_bridge_name_single            = "bot_fredrick_event_bridge_prod"
event_bridge_name_tag               = {"Name": "bot_fredrick_event_bridge_prod"}
event_bridge_schedule               = "cron(5 0 ? * TUE *)"            # Every Tuesday at 11:05AM. AWS CRON in UTC timezone, AEST = UTC + 11hrs.  