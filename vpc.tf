resource "aws_vpc" "terraform-vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    enable_classiclink = "false"
    tags = {
        Name = "terraform-vpc-terraform"
    }
}

resource "aws_subnet" "terraform-public-1" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1a"

    tags = {
        Name = "terraform-public-1"
    }
}

resource "aws_subnet" "terraform-public-2" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1b"

    tags = {
        Name = "terraform-public-2"
    }
}

resource "aws_subnet" "terraform-public-3" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "ap-southeast-1c"

    tags = {
        Name = "terraform-public-3"
    }
}

resource "aws_subnet" "terraform-private-1" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "ap-southeast-1a"

    tags = {
        Name = "terraform-private-1"
    }
}

resource "aws_subnet" "terraform-private-2" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "ap-southeast-1b"

    tags = {
        Name = "terraform-private-2"
    }
}

resource "aws_subnet" "terraform-private-3" {
    vpc_id = aws_vpc.terraform-vpc.id
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "ap-southeast-1c"

    tags = {
        Name = "terraform-private-3"
    }
}

resource "aws_internet_gateway" "terraform-gw" {
    vpc_id = aws_vpc.terraform-vpc.id

    tags = {
        Name = "terraform-gw"
     }
}

resource "aws_route_table" "terraform-public" {
    vpc_id = aws_vpc.terraform-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform-gw.id
    }

    tags = {
        Name = "terraform-public-1"
    }
}

resource "aws_route_table_association" "terraform-public-1a" {
    subnet_id = aws_subnet.terraform-public-1.id
    route_table_id = aws_route_table.terraform-public.id
}

resource "aws_route_table_association" "terraform-public-2a" {
    subnet_id = aws_subnet.terraform-public-2.id
    route_table_id = aws_route_table.terraform-public.id
}

resource "aws_route_table_association" "terraform-public-3a" {
    subnet_id = aws_subnet.terraform-public-3.id
    route_table_id = aws_route_table.terraform-public.id
}  