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
    vpc_cidr_block                                = "10.0.0.0/24"
    vpc_tags                                      = "${merge({"Name": "bot_fredrick_vpc_${var.logical_environment}"},local.info_tags)}"

    # Public Subnet
    public_subnet_tags                            = "${merge({"Name": "bot_fredrick_public_subnet_${var.logical_environment}"},local.info_tags)}"
    public_subnet_cidr_block                      = "10.0.0.0/28"
    eip_tags                                      = "${merge({"Name": "bot_fredrick_eip_${var.logical_environment}"},local.info_tags)}"
    public_route_table_tags                       = "${merge({"Name": "bot_fredrick_public_route_table_${var.logical_environment}"},local.info_tags)}"

    # Private Subnet
    private_subnet_tags                           = "${merge({"Name": "bot_fredrick_private_subnet_${var.logical_environment}"},local.info_tags)}"
    private_subnet_cidr_block                     = "10.0.0.16/28"
    nat_instance_tags                                   = "${merge({"Name": "bot_fredrick_nat_instance_${var.logical_environment}"},local.info_tags)}"
    private_route_table_tags                      = "${merge({"Name": "bot_fredrick_private_route_table_${var.logical_environment}"},local.info_tags)}"

    # Internet Gateway
    internet_gateway_tags                         = "${merge({"Name": "bot_fredrick_igw_${var.logical_environment}"},local.info_tags)}"

    # Security group - create_poll
    create_poll_lambda_security_group_tags        = "${merge({"Name": "bot_fredrick_sg_create_poll_lambda_${var.logical_environment}"},local.info_tags)}"

    # NAT Instance SG
    nat_instance_security_group_tags              = "${merge({"Name": "bot_fredrick_sg_nat_instance_${var.logical_environment}"},local.info_tags)}"
}

module "compute" {
    source = "./modules/compute"

    # Lambda - General
    lambda_private_subnet_id                      = module.networking.private_subnet_id
    lambda_environment_variable_env               = "${var.logical_environment}"

    # Lambda - create_poll
    create_poll_lambda_name                       = "bot_fredrick_create_poll_lambda_${var.logical_environment}"
    create_poll_lambda_tags                       = "${merge({"Name": "bot_fredrick_create_poll_lambda_${var.logical_environment}"},local.info_tags)}"
    create_poll_lambda_iam_role                   = module.security_identity_compliance.iam_role_create_poll_lambda_arn
    create_poll_lambda_security_group             = module.networking.create_poll_lambda_security_group_id

    # EventBridge - create_poll
    create_poll_eventbridge_arn                   = module.application_integration.create_poll_eventbridge_rule_arn

    # Lambda Layer - Headless Chromium
    headless_chromium_name                        = "HeadlessChromium_${var.logical_environment}"
    headless_chromium_version                     = "${var.headlesschromium_version}"

    # S3 - State bucket name
    upload_bucket_lambda_layer                    = "${var.state_bucket_name}"
}

module "security_identity_compliance" {
    source = "./modules/security_identity_compliance"
    # IAM Role - create_poll
    create_poll_lambda_iam_role_name              = "bot_fredrick_create_poll_iam_role_lambda_${var.logical_environment}"
    create_poll_lambda_iam_role_tags              = "${merge({"Name": "bot_fredrick_create_poll_iam_role_lambda_${var.logical_environment}"},local.info_tags)}"

    # SSM IAM Policy - create_poll
    create_poll_lambda_ssm_iam_policy_name        = "AllowLambdaReadSSMParameterAccessBotFredrickCreatePoll_${var.logical_environment}"
    create_poll_lambda_ssm_iam_policy_tags        = "${merge({"Name": "AllowLambdaReadSSMParameterAccessBotFredrickCreatePoll_${var.logical_environment}"},local.info_tags)}"

    # SSM Parameter ARN - email
    ssm_parameter_email_arn                       = module.management_governance.ssm_parameter_service_account_email_unique_arn

    # SSM Parameter ARN - password
    ssm_parameter_password_arn                    = module.management_governance.ssm_parameter_service_account_password_unique_arn

    # SSM Parameter ARN - thread_id
    ssm_parameter_thread_id_arn                   = module.management_governance.ssm_parameter_thread_id_unique_arn
}

module "application_integration" {
    source = "./modules/application_integration"

    # Event Bridge - create_poll
    create_poll_event_bridge_name                 = "bot_fredrick_create_poll_event_bridge_${var.logical_environment}"
    create_poll_event_bridge_name_tags            = "${merge({"Name": "bot_fredrick_create_poll_event_bridge_${var.logical_environment}"},local.info_tags)}"
    create_poll_event_bridge_schedule             = "${var.create_poll_event_bridge_schedule}"

    # Lambda ARN - create_poll
    create_poll_lambda_function_arn               = module.compute.create_poll_lambda_function_unique_arn
}

module "management_governance" {
    source = "./modules/management_governance"
    
    # SSM Parameter - email
    ssm_parameter_account_email_name         = "bot_fredrick_email_${var.logical_environment}"
    ssm_parameter_account_email_value        = "${var.account_email}"
    ssm_parameter_account_email_tags         = "${merge({"Name": "bot_fredrick_email_${var.logical_environment}"},local.info_tags)}"
    
    # SSM Parameter - password
    ssm_parameter_account_password_name      = "bot_fredrick_password_${var.logical_environment}"
    ssm_parameter_account_password_value     = "${var.account_password}"
    ssm_parameter_account_password_tags      = "${merge({"Name": "bot_fredrick_password_${var.logical_environment}"},local.info_tags)}"

    # SSM Parameter - thread_id
    ssm_parameter_thread_id_name             = "fb_group_chat_thread_id_${var.logical_environment}"
    ssm_parameter_thread_id_value            = "${var.thread_id}"
    ssm_parameter_thread_id_tags             = "${merge({"Name": "fb_group_chat_thread_id_${var.logical_environment}"},local.info_tags)}"
}
