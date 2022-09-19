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