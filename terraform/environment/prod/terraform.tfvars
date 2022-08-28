# General
aws_region                        = "ap-southeast-2"
generic_tags    = {
    "Environment": "prod"
    "Project": "bot_fredrick"
}

# VPC
vpc_cidr_block                  = "10.0.0.0/24"
vpc_name_tag                    = {"Name": "bot_fredrick_vpc_prod"}

# Security group
lambda_name_tag                 = {"Name": "bot_fredrick_lambda_prod"}

# IAM Role
lambda_iam_name_tag             = {"Name": "bot_fredrick_iam_role_lambda_prod"}