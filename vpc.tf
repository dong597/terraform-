resource "aws_vpc" "terrafom_vpc1" {
    cidr_block = "172.18.0.0/16"
    tags = {
        Name = "terrafom_vpc1"
    }

}

resource "aws_subnet" "mgmt" {
    vpc_id = aws_vpc.terrafom_vpc1.id
    cidr_block = "172.18.1.0/24"
    availability_zone = "ap-northeast-1a"

    tags = {
    Name = "mgmt"
    }
}

resource "aws_subnet" "web" {
    vpc_id = aws_vpc.terrafom_vpc1.id
    cidr_block = "172.18.2.0/24"
    availability_zone = "ap-northeast-1a"

    tags = {
    Name = "web"
    }
}

resource "aws_subnet" "backup" {
    vpc_id = aws_vpc.terrafom_vpc1.id
    cidr_block = "172.18.3.0/24"
    availability_zone = "ap-northeast-1c"

    tags = {
    Name = "backup"
    }
}

resource "aws_internet_gateway" "terraform_gw" {
    vpc_id = aws_vpc.terrafom_vpc1.id

    tags = {
        Name = "terraform_gw"
    }
}

resource "aws_route_table" "terraform_route_table_internet" {
     vpc_id = aws_vpc.terrafom_vpc1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.terraform_gw.id
    }

    tags = {
        Name = "routingtable_terraform_internet"
    }
}

resource "aws_route_table" "terraform_route_table_nointernet" {
     vpc_id = aws_vpc.terrafom_vpc1.id

    tags = {
        Name = "routingtable_terraform_nointernet"
    }
}

resource "aws_route_table_association" "mgmt" {
    subnet_id      = aws_subnet.mgmt.id
    route_table_id = aws_route_table.terraform_route_table_internet.id
}

resource "aws_route_table_association" "web" {
    subnet_id      = aws_subnet.web.id
    route_table_id = aws_route_table.terraform_route_table_internet.id
}

resource "aws_route_table_association" "backup" {
    subnet_id      = aws_subnet.backup.id
    route_table_id = aws_route_table.terraform_route_table_nointernet.id
}