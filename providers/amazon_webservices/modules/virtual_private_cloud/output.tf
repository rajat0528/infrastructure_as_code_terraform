#VPC
output "vpc_id" {
  description = "The ID of the VPC"
  value       = concat(aws_vpc.main.*.id, [""])[0]
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = concat(aws_vpc.main.*.arn, [""])[0]
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = concat(aws_vpc.main.*.cidr_block, [""])[0]
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = concat(aws_vpc.main.*.default_route_table_id, [""])[0]
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = concat(aws_vpc.main.*.instance_tenancy, [""])[0]
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = concat(aws_vpc.main.*.enable_dns_support, [""])[0]
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = concat(aws_vpc.main.*.enable_dns_hostnames, [""])[0]
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = concat(aws_vpc.main.*.main_route_table_id, [""])[0]
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = concat(aws_vpc.main.*.ipv6_association_id, [""])[0]
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value       = concat(aws_vpc.main.*.ipv6_cidr_block, [""])[0]
}

output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = concat(aws_vpc.main.*.owner_id, [""])[0]
}