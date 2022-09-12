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
    enable_classiclink                  =   var.vpc_enable_classiclink
}

# VPC IPv4 Association
resource "aws_vpc_ipv4_cidr_block_association" "this" {
    count = var.create_vpc && length(var.vpc_secondary_cidr_blocks) > 0 ? length(var.vpc_secondary_cidr_blocks) : 0

    vpc_id = aws_vpc.main[0].id
    cidr_block = element(var.vpc_secondary_cidr_blocks, count.index)
}

# Subnet Public
resource "aws_subnet" "public" {
    count                     =   var.create_vpc && length(var.subnet_cidr_public) > 0 ? length(var.subnet_cidr_public) : 0

    vpc_id                    =   local.vpc_id
    cidr_block                =   element(var.subnet_cidr_public,count.index)
    availability_zone         =   element(var.subnet_availability_zone_public,count.index)
    map_public_ip_on_launch   =   element(var.subnet_map_public_ip_on_launch_public,count.index)
    tags                      =   element(var.subnet_tags_public,count.index)
}

# Subnet Private
resource "aws_subnet" "private" {
    count                     =   var.create_vpc && length(var.subnet_cidr_private) > 0 ? length(var.subnet_cidr_private) : 0

    vpc_id                    =   local.vpc_id
    cidr_block                =   element(var.subnet_cidr_private,count.index)
    availability_zone         =   element(var.subnet_availability_zone_private,count.index)
    map_public_ip_on_launch   =   element(var.subnet_map_public_ip_on_launch_private,count.index)
    tags                      =   element(var.subnet_tags_private,count.index)
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
    count   =   var.create_vpc && length(var.internetgateway_tags) > 0 ? length(var.internetgateway_tags) : 0

    vpc_id  =   local.vpc_id
    tags    =   element(element(var.internetgateway_tags,count.index),count.index)
}

# Route Table Public
resource "aws_route_table" "public" {
    count   =   var.create_vpc && length(var.route_table_tags_public) > 0 ? length(var.route_table_tags_public) : 0

    vpc_id  =   local.vpc_id
    tags    =   element(element(var.route_table_tags_public,count.index),count.index)
}

# Route Table Private
resource "aws_route_table" "private" {
    count   =   var.create_vpc && length(var.route_table_tags_private) > 0 ? length(var.route_table_tags_private) : 0

    vpc_id  =   local.vpc_id
    tags    =   element(element(var.route_table_tags_private,count.index),count.index)
}

# NAT Elastic IP
resource "aws_eip" "nateip" {
    count   =   var.create_vpc && length(var.nat_elastic_ip) > 0 ? length(var.nat_elastic_ip) : 0

    vpc     =   true
    tags    =   element(var.nat_elastic_ip[count.index].tags,count.index)
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
    count   =   var.create_vpc && length(var.nat_gateway_private) > 0 ? length(var.nat_gateway_private) : 0

    allocation_id = element(
        split(
            ",",
            join(",", var.nat_gateway_private[count.index].nat_eip_id)
        ),
        length(var.nat_gateway_private) == 0 ? 0 : count.index,
    )
    subnet_id = element(
        var.nat_gateway_private[count.index].public_subnet_id,
        length(var.nat_gateway_private) == 0 ? 0 : count.index,
    )

    tags    =   element(var.nat_gateway_private[count.index].tags,count.index)
}

# Route Table Public Subnets Association
resource "aws_route_table_association" "public" {
    count       = var.create_vpc && length(var.aws_route_table_association_subnetid_public) > 0 ? length(var.aws_route_table_association_subnetid_public) : 0

    subnet_id   = element(var.aws_route_table_association_subnetid_public, count.index)
    route_table_id = element(
        var.aws_route_table_association_routeid_public, count.index
    )
}

# Route Table Private Subnets Association
resource "aws_route_table_association" "private" {
    count       = var.create_vpc && length(var.aws_route_table_association_subnetid_private) > 0 ? length(var.aws_route_table_association_subnetid_private) : 0

    subnet_id   = element(var.aws_route_table_association_subnetid_private, count.index)
    route_table_id = element(
        var.aws_route_table_association_routeid_private, count.index
    )
}

# Route NAT Gateway Association
resource "aws_route" "natgateway" {
    count                   =    var.create_vpc && length(var.aws_route_nat_gateway_association) > 0 ? length(var.aws_route_nat_gateway_association) : 0

    route_table_id          =    var.aws_route_nat_gateway_association[count.index].private_routetable_id
    destination_cidr_block  =    var.aws_route_nat_gateway_association[count.index].destination_cidr_block
    nat_gateway_id          =    var.aws_route_nat_gateway_association[count.index].nat_gateway_id

    timeouts {
        create = "5m"
    }
}

# Route Internet Gateway Association
resource "aws_route" "igw" {
    count                   =    var.create_vpc && length(var.aws_route_internet_gateway_association) > 0 ? length(var.aws_route_internet_gateway_association) : 0

    route_table_id          =    var.aws_route_internet_gateway_association[count.index].public_routetable_id
    destination_cidr_block  =    var.aws_route_internet_gateway_association[count.index].destination_cidr_block
    gateway_id              =    var.aws_route_internet_gateway_association[count.index].internet_gateway_id

    timeouts {
        create = "5m"
    }
}

# Security Group Bastion Server
resource "aws_security_group" "bastion" {
    for_each    =   {for sg in var.bastion_security_group:  sg.name => sg} 

    name        =   each.value.name
    description =   each.value.description
    vpc_id      =   local.vpc_id

    tags = {
        Name = each.value.name
    }
}

# Security Group APP Server
resource "aws_security_group" "appserver" {
    for_each    =   {for sg in var.appserver_security_group:  sg.name => sg} 

    name        =   each.value.name
    description =   each.value.description
    vpc_id      =   local.vpc_id
    
    tags = {
        Name = each.value.name
    } 
}

# Security Group APP Server ALB(Application Load Balancer)
resource "aws_security_group" "appserver_alb" {
    for_each    =   {for sg in var.appserver_alb_security_group:  sg.name => sg} 

    name        =   each.value.name
    description =   each.value.description
    vpc_id      =   local.vpc_id
    
    tags = {
        Name = each.value.name
    } 
}

# Security Group Bastion Server Rules
resource "aws_security_group_rule" "bastion" {
    count = var.create_vpc && length(var.bastion_security_group_rules) > 0 ? length(var.bastion_security_group_rules) : 0

    type                        =   var.bastion_security_group_rules[count.index].type
    to_port                     =   lookup(var.bastion_security_group_rules[count.index], "to_port", 0)
    from_port                   =   lookup(var.bastion_security_group_rules[count.index], "from_port", 0)
    protocol                    =   lookup(var.bastion_security_group_rules[count.index], "protocol", "-1")
    security_group_id           =   var.bastion_security_group_rules[count.index].security_group_id
    self                        =   lookup(var.bastion_security_group_rules[count.index], "self", false) == false ? null : null
    description                 =   lookup(var.bastion_security_group_rules[count.index], "description", "")
    cidr_blocks                 =   lookup(var.bastion_security_group_rules[count.index], "cidr_blocks", "") == "" ? null : compact(split(",", lookup(var.bastion_security_group_rules[count.index], "cidr_blocks", "")))
    source_security_group_id    =   lookup(var.bastion_security_group_rules[count.index], "source_security_group_id", "") == "" ? null : var.bastion_security_group_rules[count.index].source_security_group_id   
}

# Security Group AppServer Server Rules
resource "aws_security_group_rule" "appserver" {
    count = var.create_vpc && length(var.appserver_security_group_rules) > 0 ? length(var.appserver_security_group_rules) : 0

    type                        =   var.appserver_security_group_rules[count.index].type
    to_port                     =   lookup(var.appserver_security_group_rules[count.index], "to_port", 0)
    from_port                   =   lookup(var.appserver_security_group_rules[count.index], "from_port", 0)
    protocol                    =   lookup(var.appserver_security_group_rules[count.index], "protocol", "-1")
    security_group_id           =   var.appserver_security_group_rules[count.index].security_group_id
    self                        =   lookup(var.appserver_security_group_rules[count.index], "self", false) == false ? null : null
    description                 =   lookup(var.appserver_security_group_rules[count.index], "description", "")
    cidr_blocks                 =   lookup(var.appserver_security_group_rules[count.index], "cidr_blocks", "") == "" ? null : compact(split(",", lookup(var.appserver_security_group_rules[count.index], "cidr_blocks", "")))
    source_security_group_id    =   lookup(var.appserver_security_group_rules[count.index], "source_security_group_id", "") == "" ? null : var.appserver_security_group_rules[count.index].source_security_group_id
}

# Security Group AppServer Server ALB(Application Load Balancer) Rules
resource "aws_security_group_rule" "appserver_alb" {
    count = var.create_vpc && length(var.appserver_alb_security_group_rules) > 0 ? length(var.appserver_alb_security_group_rules) : 0

    type                        =   var.appserver_alb_security_group_rules[count.index].type
    to_port                     =   lookup(var.appserver_alb_security_group_rules[count.index], "to_port", 0)
    from_port                   =   lookup(var.appserver_alb_security_group_rules[count.index], "from_port", 0)
    protocol                    =   lookup(var.appserver_alb_security_group_rules[count.index], "protocol", "-1")
    security_group_id           =   var.appserver_alb_security_group_rules[count.index].security_group_id
    self                        =   lookup(var.appserver_alb_security_group_rules[count.index], "self", false) == false ? null : null
    description                 =   lookup(var.appserver_alb_security_group_rules[count.index], "description", "")
    cidr_blocks                 =   lookup(var.appserver_alb_security_group_rules[count.index], "cidr_blocks", "") == "" ? null : compact(split(",", lookup(var.appserver_alb_security_group_rules[count.index], "cidr_blocks", "")))
    source_security_group_id    =   lookup(var.appserver_alb_security_group_rules[count.index], "source_security_group_id", "") == "" ? null : var.appserver_alb_security_group_rules[count.index].source_security_group_id  
}