# Default configurations
application                     =   "infraguard"
environment                     =   "staging"
aws_region                      =   "ap-southeast-1"
shared_config_files             =   ["/Users/Infraguard/.aws/config"]
shared_credentials_files        =   ["/Users/Infraguard/.aws/credentials"]
aws_credentials_profile         =   "infraguardtestingaccount"
aws_assume_role_rolearn         =   "arn:aws:iam::348694061691:role/infraguard-enterprise-saas-deployment-role"
aws_assume_role_session_name    =   "infraguard-app-session"
aws_assume_role_external_id     =   "InfraGuardAppp:app"

# VPC configurations
vpc_configurations              =   {
    vpc_cidr_block                          :   "172.30.0.0/26"
    vpc_instance_tenancy                    :   "default"
    vpc_enable_dns_support                  :   true
    vpc_enable_dns_hostnames                :   true
    vpc_assign_generated_ipv6_cidr_block    :   false
    vpc_tags            :   [
        {
            Name        =   "vpc-ap-southeast-1-staging-infraguard"
            Envrionment =   "staging"
        }
    ]
}