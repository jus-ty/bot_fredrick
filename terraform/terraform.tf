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
    vpc_cidr_block            = "${var.vpc_cidr_block}"
    vpc_tags                  = "${merge(var.vpc_name_tag,var.generic_tags)}"

    # Security group
    lambda_security_group_tags    = "${merge(var.lambda_name_tag,var.generic_tags)}"
}

module "compute" {
    source = "./modules/compute"

    
}

module "security_identity_compliance" {
    source = "./modules/security_identity_compliance"

    # IAM Role
    lambda_iam_role_name = "${var.lambda_iam_name_tag}"
    lambda_iam_role_tags = "${merge(var.lambda_iam_name_tag,var.generic_tags)}"
}