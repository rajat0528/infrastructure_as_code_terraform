# Subnet public
output "subnet_public_vpcid" {
  description = "List of vpc id attached to public subnet"
  value       = aws_subnet.public.*.vpc_id
}

output "subnet_public_id" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public.*.id
}

output "subnet_public_arn" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public.*.arn
}

output "subnet_public_cidr_block" {
  description = "List of cidr_blocks of public subnets"
  value       = aws_subnet.public.*.cidr_block
}

output "subnet_public_ipv6_cidr_block" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = aws_subnet.public.*.ipv6_cidr_block
}

# Subnet private
output "subnet_private_vpcid" {
  description = "List of vpc id attached to private subnet"
  value       = aws_subnet.private.*.vpc_id
}

output "subnet_private_id" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private.*.id
}

output "subnet_private_arn" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private.*.arn
}

output "subnet_private_cidr_block" {
  description = "List of cidr_blocks of private subnets"
  value       = aws_subnet.private.*.cidr_block
}

output "subnet_private_ipv6_cidr_block" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = aws_subnet.private.*.ipv6_cidr_block
}