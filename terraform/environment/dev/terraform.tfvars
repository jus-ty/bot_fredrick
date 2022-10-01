# General
aws_region                          = "ap-southeast-2"
logical_environment                 = "dev"
generic_tags    = {
    "Environment": "dev"
    "Project": "bot_fredrick"
}

# VPC
vpc_name_tag                        = {"Name": "bot_fredrick_vpc_dev"}

# Public subnet
public_subnet_name_tag              = {"Name": "bot_fredrick_public_subnet_dev"}
eip_name_tag                        = {"Name": "bot_fredrick_eip_dev"}
public_route_table_name_tag         = {"Name": "bot_fredrick_public_route_table_dev"}

# Private subnet
private_subnet_name_tag             = {"Name": "bot_fredrick_private_subnet_dev"}
nat_gw_name_tag                     = {"Name": "bot_fredrick_nat_gw_dev"}
private_route_table_name_tag        = {"Name": "bot_fredrick_private_route_table_dev"}

# Internet gateway
igw_name_tag                        = {"Name": "bot_fredrick_igw_dev"}

# Security group
lambda_sg_name_tag                  = {"Name": "bot_fredrick_sg_lambda_dev"}

# Lambda
lambda_name_single                  = "bot_fredrick_lambda_dev"
lambda_name_tag                     = {"Name": "bot_fredrick_lambda_dev"}

# IAM Role
lambda_iam_name_single              = "bot_fredrick_iam_role_lambda_dev"
lambda_iam_name_tag                 = {"Name": "bot_fredrick_iam_role_lambda_dev"}

# Event Bridge
event_bridge_name_single            = "bot_fredrick_event_bridge_dev"
event_bridge_name_tag               = {"Name": "bot_fredrick_event_bridge_dev"}
event_bridge_schedule               = "cron(5 0 ? * * *)"            # Every day at 11:05AM. AWS CRON in UTC timezone, AEST = UTC + 11hrs.  
#"cron(5 0/2 ? * * *)"           # At 5 minutes past the hour, every 2 hours