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