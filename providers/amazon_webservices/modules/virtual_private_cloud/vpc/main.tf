locals {
  vpc_id = element(
    concat(
      aws_vpc_ipv4_cidr_block_association.this.*.vpc_id,
      aws_vpc.main.*.id,
      [""],
    ),
    0,
  )
}

# VPC
resource "aws_vpc" "main" {
    count = var.create_vpc ? 1 : 0

    cidr_block                          =   var.vpc_cidr_block
    instance_tenancy                    =   var.vpc_instance_tenancy
    enable_dns_support                  =   var.vpc_enable_dns_support
    enable_dns_hostnames                =   var.vpc_enable_dns_hostnames
    assign_generated_ipv6_cidr_block    =   var.vpc_assign_generated_ipv6_cidr_block
    tags                                =   element(var.vpc_tags,count.index)
}

# VPC IPv4 Association
resource "aws_vpc_ipv4_cidr_block_association" "this" {
    count = var.create_vpc && length(var.vpc_secondary_cidr_blocks) > 0 ? length(var.vpc_secondary_cidr_blocks) : 0

    vpc_id = aws_vpc.main[0].id
    cidr_block = element(var.vpc_secondary_cidr_blocks, count.index)
}