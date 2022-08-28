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
}

module "compute" {
    source = "./modules/compute"

}