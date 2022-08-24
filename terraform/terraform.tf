terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  backend "s3" {
    bucket = "terraform-state-537519792485"
    key    = "bot_fredrick"
    region = "ap-southeast-2"
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