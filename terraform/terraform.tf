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
    vpc_tags                        = "${merge(var.vpc_name_tag,var.generic_tags)}"

    # Public Subnet
    public_subnet_tags              = "${merge(var.public_subnet_name_tag,var.generic_tags)}"
    public_subnet_cidr_block        = "10.0.0.0/28"
    eip_tags                        = "${merge(var.eip_name_tag,var.generic_tags)}"
    public_route_table_tags         = "${merge(var.public_route_table_name_tag,var.generic_tags)}"

    # Private Subnet
    private_subnet_tags             = "${merge(var.private_subnet_name_tag,var.generic_tags)}"
    private_subnet_cidr_block       = "10.0.0.16/28"
    nat_gw_tags                     = "${merge(var.nat_gw_name_tag,var.generic_tags)}"
    private_route_table_tags        = "${merge(var.private_route_table_name_tag,var.generic_tags)}"

    # Internet Gateway
    internet_gateway_tags           = "${merge(var.igw_name_tag,var.generic_tags)}"

    # Security group
    lambda_security_group_tags      = "${merge(var.lambda_sg_name_tag,var.generic_tags)}"
}

module "compute" {
    source = "./modules/compute"

    # Lambda
    lambda_name                     = "${var.lambda_name_single}"
    lambda_name_tags                = "${merge(var.lambda_name_tag,var.generic_tags)}"
    lambda_arn                      = module.compute.lambda_function_unique_arn      # To access one of the module's output values, use module.<MODULE NAME>.<OUTPUT NAME>. Ref: https://www.terraform.io/language/expressions/references
    lambda_iam_role                 = module.security_identity_compliance.iam_role_lambda_arn
    lambda_security_group           = module.networking.lambda_security_group_id
    lambda_subnet_id                = module.networking.private_subnet_id
    lambda_environment_variable_env = "${var.logical_environment}"
}

module "security_identity_compliance" {
    source = "./modules/security_identity_compliance"

    # IAM Role
    lambda_iam_role_name            = "${var.lambda_iam_name_single}"
    lambda_iam_role_tags            = "${merge(var.lambda_iam_name_tag,var.generic_tags)}"

    # SSM IAM Policy
    lambda_ssm_iam_policy_name      = "AllowLambdaReadSSMParameterAccessBotFredrick"
    lambda_ssm_iam_policy_tags      = "${merge({"Name": "AllowLambdaReadSSMParameterAccessBotFredrick"},var.generic_tags)}"
}

module "application_integration" {
  source = "./modules/application_integration"

  # Event Bridge
  event_bridge_name       = "${var.event_bridge_name_single}"
  event_bridge_name_tags  = "${merge(var.event_bridge_name_tag,var.generic_tags)}"
  event_bridge_schedules  = "${var.event_bridge_schedule}"

  # Lambda ARN
  lambda_function_arn     = module.compute.lambda_arn
}
