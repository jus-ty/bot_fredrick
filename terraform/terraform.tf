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
    public_route_table_tags   = "${merge(var.public_route_table_name_tag,var.generic_tags)}"
    private_route_table_tags  = "${merge(var.private_route_table_name_tag,var.generic_tags)}"

    # Public Subnet
    public_subnet_tags        = "${merge(var.public_subnet_name_tag,var.generic_tags)}"
    public_subnet_cidr_block  = "${var.public_subnet_cidr_block}"
    eip_tags                  = "${merge(var.eip_name_tag,var.generic_tags)}"

    # Private Subnet
    private_subnet_tags       = "${merge(var.private_subnet_name_tag,var.generic_tags)}"
    private_subnet_cidr_block = "${var.private_subnet_cidr_block}"
    nat_gw_tags               = "${merge(var.nat_gw_name_tag,var.generic_tags)}"

    # Internet Gateway
    internet_gateway_tags     = "${merge(var.igw_name_tag,var.generic_tags)}"

    # Bastion - Security Group tags
    bastion_security_group_tags   = "${merge(var.bastion_security_group_name_tag,var.generic_tags)}"
    bastion_instance_type         = "${var.bastion_instance_ec2_type}"

    # Private instance - Security Group tags
    private_instance_security_group_tags  = "${merge(var.private_instance_security_group_name_tag,var.generic_tags)}"
    private_instance_type                 = "${var.private_instance_ec2_type}"
}

module "compute" {
    source = "./modules/compute"
    
    # EC2
    private_instance_ami        = "${var.private_instance_ec2_ami}"
    bastion_ami                 = "${var.bastion_ec2_ami}"

    # EC2 - bastion
    bastion_tags                = "${merge(var.bastion_name_tag,var.generic_tags)}"
    public_subnet_id            = module.networking.public_subnet_id
    bastion_security_group_id   = module.networking.bastion_security_group_id

    # EC2 - private host
    private_instance_tags               = "${merge(var.private_instance_name_tag,var.generic_tags)}"
    private_subnet_id                   = module.networking.private_subnet_id
    private_instance_security_group_id  = module.networking.private_instance_security_group_id
}