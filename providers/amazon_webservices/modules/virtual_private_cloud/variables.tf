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
    description = "List of secondary CIDR blocks to associate with the VPC to extend the IP Address pool"
    default     = []
}


/*
*   @Name: Subnets
*   Description: A subnet group is a collection of subnets (typically private) that you can designate for your clusters running in an Amazon Virtual Private Cloud (VPC).
*/

variable "subnet_cidr_public" {
    type        =   list
    description =   "The CIDR block for the public subnet."
    default     =   []
}

variable "subnet_availability_zone_public" {
    type        =   list
    description =   "The availability zone where the public subnet must reside."
    default     =   []
}

variable "subnet_map_public_ip_on_launch_public" {
    type        =   list
    description =   "Specify true to indicate that instances launched into the public subnet should be assigned a public IP address. Default is false."
    default     =   []
}

variable "subnet_tags_public" {
    type        =   list(map(any))
    description =   "A map of tags to assign to the resource."
    default     =   []
}

variable "subnet_cidr_private" {
    type        =   list
    description =   "The CIDR block for the private subnet."
    default     =   []
}

variable "subnet_availability_zone_private" {
    type        =   list
    description =   "The availability zone where the private subnet must reside."
    default     =   []
}

variable "subnet_map_public_ip_on_launch_private" {
    type        =   list
    description =   "Specify true to indicate that instances launched into the private subnet should be assigned a public IP address. Default is false."
    default     =   []
}

variable "subnet_tags_private" {
    type        =   list(map(any))
    description =   "A map of tags to assign to the resource."
    default     =   []
}


/*
*   @Name: Internet Gateway
*   Description: An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet.
*/

variable "internetgateway_tags" {
    type        =   list(list(map(any)))
    description =   "A map of tags to assign to the resource."
    default     =   []
}


/*
*   @Name: Route Table
*   Description: A route table contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed.
*/

variable "route_table_tags_public" {
    type        =   list(list(map(any)))
    description =   "A map of tags to assign to the resource."
    default     =   []
}

variable "route_table_tags_private" {
    type        =   list(list(map(any)))
    description =   "A map of tags to assign to the resource."
    default     =   []
}

variable "aws_route_table_association_subnetid_public" {
    type        =   list
    description =   "A list of public subnets inside the VPC."
    default     =   []
}

variable "aws_route_table_association_routeid_public" {
    type        =   list
    description =   "List of IDs of public route tables."
    default     =   []
}

variable "aws_route_table_association_subnetid_private" {
    type        =   list
    description =   "A list of private subnets inside the VPC."
    default     =   []
}

variable "aws_route_table_association_routeid_private" {
    type        =   list
    description =   "List of IDs of private route tables."
    default     =   []
}

variable "aws_route_nat_gateway_association" {
    type        =   list(any)
    description =   "Assign nat gateway to route table"
    default     =   []
}

variable "aws_route_internet_gateway_association" {
    type        =   list(any)
    description =   "Assign internet gateway to route table"
    default     =   []
}

/*
*   @Name: NAT Gateway
*   Description: You can use a network address translation (NAT) gateway to enable instances in a private subnet to connect to the internet or other AWS services, but prevent the internet from initiating a connection with those instances.
*/
variable "nat_elastic_ip" {
    type        =   list(any)
    description =   "NAT elastic IP. It will be associated with nat gateway"
    default     =   []
}

variable "nat_gateway_private" {
    type        =   list(any)
    description =   "List of NAT gateways for private instances."
    default     =   []
}


/*
*   @Name: Security Group
*   Description: A security group acts as a virtual firewall for your instance to control inbound and outbound traffic.
*/
variable "bastion_security_group" {
    type        =   list(any)
    description =   "List of security groups for bastion."
    default     =   []
}

variable "appserver_security_group" {
    type        =   list(any)
    description =   "List of security groups for appserver."
    default     =   []
}

variable "appserver_alb_security_group" {
    type        =   list(any)
    description =   "List of security groups for appserver alb."
    default     =   []
}

variable "bastion_security_group_rules" {
    type        =   list(any)
    description =   "List of security group rules for bastion."
    default     =   []
}

variable "appserver_security_group_rules" {
    type        =   list(any)
    description =   "List of security group rules for appserver."
    default     =   []
}

variable "appserver_alb_security_group_rules" {
    type        =   list(any)
    description =   "List of security group rules for appserver alb."
    default     =   []
}