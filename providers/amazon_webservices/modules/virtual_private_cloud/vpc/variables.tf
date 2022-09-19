/*
*   @Name: VPC
*   Description: Amazon Virtual Private Cloud (Amazon VPC) enables you to launch AWS resources into a virtual network that you've defined.
*/
variable "create_vpc" {
    type        =   bool
    description =   "Controls if VPC should be created (it affects almost all resources)"    
    default     =   true
}
variable "vpc_cidr_block" {
    type        =   string
    description =   "The CIDR block for the VPC."
}

variable "vpc_instance_tenancy" {
    type        =   string
    default     =   "default"
    description =   "A tenancy option for instances launched into the VPC. Default is default, which makes your instances shared on the host. Using either of the other options (dedicated or host) costs at least $2/hr."
}

variable "vpc_enable_dns_support" {
    type        =   bool
    default     =   true
    description =   "A boolean flag to enable/disable DNS support in the VPC. Defaults true."
}

variable "vpc_enable_dns_hostnames" {
    type        =   bool
    default     =   true
    description =   "A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false."
}

variable "vpc_enable_classiclink" {
    type        =   bool
    default     =   false
    description =   "A boolean flag to enable/disable ClassicLink for the VPC. Only valid in regions and accounts that support EC2 Classic."
}

variable "vpc_assign_generated_ipv6_cidr_block" {
    type        =   bool
    default     =   false
    description =   "Requests an Amazon-provided IPv6 CIDR block with a /56 prefix length for the VPC. You cannot specify the range of IP addresses, or the size of the CIDR block."
}

variable "vpc_enable_classiclink_dns_support" {
    type        = bool
    description = "Should be true to enable ClassicLink DNS Support for the VPC. Only valid in regions and accounts that support EC2 Classic."
    default     = null
}

variable "vpc_tags" {
    type        =   list(map(any))
    description =   "A map of tags to assign to the resource.."
}

variable "vpc_secondary_cidr_blocks" {
    type        = list(string)
    description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool."
    default     = []
}