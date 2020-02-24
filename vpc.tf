locals {
  subnets = {
    "${var.region}a" = "172.16.0.0/21"
    "${var.region}b" = "172.16.8.0/21"
    "${var.region}c" = "172.16.16.0/21"
  }
}

resource "aws_vpc" "demo-app" {
  cidr_block = "172.16.0.0/16"

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "example-vpc"
  }
}

resource "aws_internet_gateway" "demo-app" {
  vpc_id = "${aws_vpc.demo-app.id}"

  tags = {
    Name = "example-internet-gateway"
  }
}

resource "aws_subnet" "demo-app" {
  count      = "${length(local.subnets)}"
  cidr_block = "${element(values(local.subnets), count.index)}"
  vpc_id     = "${aws_vpc.demo-app.id}"

  map_public_ip_on_launch = true
  availability_zone       = "${element(keys(local.subnets), count.index)}"

  tags = {
    Name = "${element(keys(local.subnets), count.index)}"
  }
}

resource "aws_route_table" "demo-app" {
  vpc_id = "${aws_vpc.demo-app.id}"

  tags = {
    Name = "example-route-table-public"
  }
}

resource "aws_route" "demo-app" {
  route_table_id         = "${aws_route_table.demo-app.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.demo-app.id}"
}

resource "aws_route_table_association" "demo-app" {
  count          = "${length(local.subnets)}"
  route_table_id = "${aws_route_table.demo-app.id}"
  subnet_id      = "${element(aws_subnet.demo-app.*.id, count.index)}"
}
