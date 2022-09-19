variable "application" {
    type        =   string
    description =   "Application name."
    default     =   "staging"
}

variable "environment" {
    type        =   string
    description =   "Environment name(Either production or staging)."
    default     =   "staging"
}

variable "aws_region" {
    type        =   string
    description =   "Define AWS region where the resources will be allocated."
}

variable "shared_credentials_files" {
    type        =   list(string)
    description =   "Default path for AWS IAM credentials(Access ID & Secret key)."
}

variable "shared_config_files" {
    type        =   list(string)
    description =   "Default path for config file."
}

variable "aws_credentials_profile" {
    type        =   string
    description =   "Profile name for aws credentials."
}

variable "aws_assume_role_rolearn" {
    type        =   string
    description =   "ARN of the IAM Role to assume."
}

variable "aws_assume_role_session_name" {
    type        =   string
    description =   "Session name to use when assuming the role."
}

variable "aws_assume_role_external_id" {
    type        =   string
    description =   "External identifier to use when assuming the role."
}

variable "vpc_configurations" {
    type        =   object({
                        vpc_cidr_block                          =   string
                        vpc_instance_tenancy                    =   string
                        vpc_enable_dns_support                  =   bool
                        vpc_enable_dns_hostnames                =   bool
                        vpc_assign_generated_ipv6_cidr_block    =   bool
                        vpc_tags                                =   list(map(any))
                    })
    description =   "Amazon Virtual Private Cloud (Amazon VPC) configurations."
}