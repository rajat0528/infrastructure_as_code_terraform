# Subnet Public
resource "aws_subnet" "public" {
    count                     =   length(var.subnet_cidr_public) > 0 ? length(var.subnet_cidr_public) : 0

    vpc_id                    =   element(var.subnet_vpcid_public,count.index)
    cidr_block                =   element(var.subnet_cidr_public,count.index)
    availability_zone         =   element(var.subnet_availability_zone_public,count.index)
    map_public_ip_on_launch   =   element(var.subnet_map_public_ip_on_launch_public,count.index)
    tags                      =   element(var.subnet_tags_public,count.index)
}

# Subnet Private
resource "aws_subnet" "private" {
    count                     =   length(var.subnet_cidr_private) > 0 ? length(var.subnet_cidr_private) : 0

    vpc_id                    =   element(var.subnet_vpcid_private,count.index)
    cidr_block                =   element(var.subnet_cidr_private,count.index)
    availability_zone         =   element(var.subnet_availability_zone_private,count.index)
    map_public_ip_on_launch   =   element(var.subnet_map_public_ip_on_launch_private,count.index)
    tags                      =   element(var.subnet_tags_private,count.index)
}