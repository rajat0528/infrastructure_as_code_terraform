provider "aws" {
    region                      =   var.aws_region
    shared_config_files         =   var.shared_config_files
    profile                     =   var.aws_credentials_profile
}

module "vpc_module" {

    # VPC module path
    source              =   "./../../../../providers/amazon_webservices/modules/virtual_private_cloud"

    # VPC configuration
    vpc_cidr_block                          =   "172.30.0.0/26"
    vpc_instance_tenancy                    =   "default"
    vpc_enable_dns_support                  =   true
    vpc_enable_dns_hostnames                =   true
    vpc_assign_generated_ipv6_cidr_block    =   false
    vpc_tags            =   [
        {
            Name        =   "vpc-${var.aws_region}-${var.environment}-infraguard"
            Envrionment =   var.environment
        }
    ]
    
}