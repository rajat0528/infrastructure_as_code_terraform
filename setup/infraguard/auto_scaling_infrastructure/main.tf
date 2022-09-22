provider "aws" {
    region                      =   var.aws_region
    #shared_config_files         =   var.shared_config_files
    #profile                     =   var.aws_credentials_profile
    assume_role {
        role_arn        =   "${var.aws_assume_role_rolearn}"
        session_name    =   "${var.aws_assume_role_session_name}"
        external_id     =   "${var.aws_assume_role_external_id}"
    }
}

locals {
  vpc_id = element(
    concat(
      module.vpc_module.*.vpc_id,
      [""],
    ),
    0,
  )
}

module "vpc_module" {

    # VPC module path
    source              =   "./../../../providers/amazon_webservices/modules/virtual_private_cloud/vpc"

    # VPC configuration
    vpc_cidr_block                          =   "${var.vpc_configurations.vpc_cidr_block}"
    vpc_instance_tenancy                    =   "${var.vpc_configurations.vpc_instance_tenancy}"
    vpc_enable_dns_support                  =   "${var.vpc_configurations.vpc_enable_dns_support}"
    vpc_enable_dns_hostnames                =   "${var.vpc_configurations.vpc_enable_dns_hostnames}"
    vpc_assign_generated_ipv6_cidr_block    =   "${var.vpc_configurations.vpc_assign_generated_ipv6_cidr_block}"
    vpc_tags                                =   "${var.vpc_configurations.vpc_tags}"
}

module "subnet_module" {

    # Subnet module path
    source              =   "./../../../providers/amazon_webservices/modules/virtual_private_cloud/subnets"

    # Subnet public configuration
    subnet_vpcid_public                    =   module.vpc_module.*.vpc_id
    subnet_cidr_public                     =   "${var.subnet_configurations.public_subnets.cidr_block}"
    subnet_availability_zone_public        =   "${var.subnet_configurations.public_subnets.availability_zone}"
    subnet_map_public_ip_on_launch_public  =   "${var.subnet_configurations.public_subnets.map_public_ip_on_launch}"
    subnet_tags_public                     =   "${var.subnet_configurations.public_subnets.tags}"

    # Subnet private configuration
    subnet_vpcid_private                    =   module.vpc_module.*.vpc_id
    subnet_cidr_private                     =   "${var.subnet_configurations.private_subnets.cidr_block}"
    subnet_availability_zone_private        =   "${var.subnet_configurations.private_subnets.availability_zone}"
    subnet_map_public_ip_on_launch_private  =   "${var.subnet_configurations.private_subnets.map_public_ip_on_launch}"
    subnet_tags_private                     =   "${var.subnet_configurations.private_subnets.tags}"
}