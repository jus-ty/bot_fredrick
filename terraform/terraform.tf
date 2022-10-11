terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
  }
}

provider "aws" {
  region = "${var.aws_region}"
}

module "networking" {
    source = "./modules/networking"

    # VPC
    vpc_cidr_block                  = "10.0.0.0/24"
    vpc_tags                        = "${merge({"Name": "bot_fredrick_vpc_${var.logical_environment}"},var.generic_tags)}"

    # Public Subnet
    public_subnet_tags              = "${merge({"Name": "bot_fredrick_public_subnet_${var.logical_environment}"},var.generic_tags)}"
    public_subnet_cidr_block        = "10.0.0.0/28"
    eip_tags                        = "${merge({"Name": "bot_fredrick_eip_${var.logical_environment}"},var.generic_tags)}"
    public_route_table_tags         = "${merge({"Name": "bot_fredrick_public_route_table_${var.logical_environment}"},var.generic_tags)}"

    # Private Subnet
    private_subnet_tags             = "${merge({"Name": "bot_fredrick_private_subnet_${var.logical_environment}"},var.generic_tags)}"
    private_subnet_cidr_block       = "10.0.0.16/28"
    nat_gw_tags                     = "${merge({"Name": "bot_fredrick_nat_gw_${var.logical_environment}"},var.generic_tags)}"
    private_route_table_tags        = "${merge({"Name": "bot_fredrick_private_route_table_${var.logical_environment}"},var.generic_tags)}"

    # Internet Gateway
    internet_gateway_tags           = "${merge({"Name": "bot_fredrick_igw_${var.logical_environment}"},var.generic_tags)}"

    # Security group
    lambda_security_group_tags      = "${merge({"Name": "bot_fredrick_sg_lambda_${var.logical_environment}"},var.generic_tags)}"
}

module "compute" {
    source = "./modules/compute"

    # Lambda
    lambda_name                     = "bot_fredrick_lambda_${var.logical_environment}"
    lambda_name_tags                = "${merge({"Name": "bot_fredrick_lambda_${var.logical_environment}"},var.generic_tags)}"
    lambda_arn                      = module.compute.lambda_function_unique_arn
    lambda_iam_role                 = module.security_identity_compliance.iam_role_lambda_arn
    lambda_security_group           = module.networking.lambda_security_group_id
    lambda_subnet_id                = module.networking.private_subnet_id
    lambda_environment_variable_env = "${var.logical_environment}"

    # EventBridge
    eventbridge_arn                 = module.application_integration.eventbridge_rule_arns
}

module "security_identity_compliance" {
    source = "./modules/security_identity_compliance"

    # IAM Role
    lambda_iam_role_name            = "bot_fredrick_iam_role_lambda_${var.logical_environment}"
    lambda_iam_role_tags            = "${merge({"Name": "bot_fredrick_iam_role_lambda_${var.logical_environment}"},var.generic_tags)}"

    # SSM IAM Policy
    lambda_ssm_iam_policy_name      = "AllowLambdaReadSSMParameterAccessBotFredrick_${var.logical_environment}"
    lambda_ssm_iam_policy_tags      = "${merge({"Name": "AllowLambdaReadSSMParameterAccessBotFredrick_${var.logical_environment}"},var.generic_tags)}"
}

module "application_integration" {
    source = "./modules/application_integration"

    # Event Bridge
    event_bridge_name                 = "bot_fredrick_event_bridge_${var.logical_environment}"
    event_bridge_name_tags            = "${merge({"Name": "bot_fredrick_event_bridge_${var.logical_environment}"},var.generic_tags)}"
    event_bridge_schedules            = "${var.event_bridge_schedule}"

    # Lambda ARN
    lambda_function_arn               = module.compute.lambda_function_unique_arn
}
