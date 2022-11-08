# NAT GATEWAY 
resource "aws_nat_gateway" "nat_gateway_prob" {
  allocation_id = aws_eip.nat_eip_prob.id
  subnet_id     = aws_subnet.pub_subnet1.id

   tags = {
    Name = "gwNAT"
  }
  depends_on = [aws_internet_gateway.gw_1]
}


# INTERNET GATEWAY
resource "aws_internet_gateway" "gw_1" {
  vpc_id = aws_vpc.dep4-vpc.id
}

# ROUTE TABLE
resource "aws_route_table" "route_table1" {
  vpc_id = aws_vpc.dep4-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw_1.id
  }
}

resource "aws_route_table_association" "route-subnet1" {
  subnet_id      = aws_subnet.pub_subnet1.id
  route_table_id = aws_route_table.route_table1.id
}


# PRIVATE ROUTE TABLE
resource "aws_route_table" "route_table2" {
  vpc_id = aws_vpc.dep4-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway_prob.id
  }
}

resource "aws_route_table_association" "route-subnet2" {
  subnet_id      = aws_subnet.pri_subnet1.id
  route_table_id = aws_route_table.route_table2.id
}

