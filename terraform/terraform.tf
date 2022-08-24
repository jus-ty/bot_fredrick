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
  region  = "${var.aws_region}"
}

# Pass in vars later!!

module "network" {
    source = "./modules/network"
    cidr_block = "${var.vpc_cidr_block}"
    tags = "${var.vpc_tags}"
}