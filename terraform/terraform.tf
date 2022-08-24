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

module "network" {
    source = "./modules/network"

    # VPC
    vpc_cidr_block = "${var.vpc_cidr_block}"
    vpc_tags = "${merge(var.vpc_name_tag,var.generic_tags)}"

    # Public Subnet
    public_subnet_tags = "${merge(var.public_subnet_name_tag,var.generic_tags)}"
    public_subnet_cidr_block = "${var.public_subnet_cidr_block}"

    # Private Subnet
    private_subnet_tags = "${merge(var.private_subnet_name_tag,var.generic_tags)}"
    private_subnet_cidr_block = "${var.private_subnet_cidr_block}"

    # Internet Gateway
    internet_gateway_tags = "${merge(var.igw_name_tag,var.generic_tags)}"

    # Security Group
    security_group_tags = "${merge(var.security_group_name_tag,var.generic_tags)}"
}

module "compute" {
    source = "./modules/compute"
    
    # EC2
    instance_ami = "${var.ec2_ami}"
    security_group_id = module.network.security_group_id

    # EC2 - bastion
    bastion_tags = "${merge(var.bastion_name_tag,var.generic_tags)}"
    public_subnet_id = module.network.public_subnet_id

    # EC2 - private host
    private_instance_tags = "${merge(var.private_instance_name_tag,var.generic_tags)}"
    private_subnet_id = module.network.private_subnet_id
}