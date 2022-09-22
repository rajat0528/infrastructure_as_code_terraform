/*
*   @Name: Subnets
*   Description: A subnet group is a collection of subnets (typically private) that you can designate for your clusters running in an Amazon Virtual Private Cloud (VPC).
*/

variable "subnet_vpcid_public" {
    type        =   list
    description =   "VPC id attached to public subnets."
    default     =   []
}

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

variable "subnet_vpcid_private" {
    type        =   list
    description =   "VPC id attached to private subnets."
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