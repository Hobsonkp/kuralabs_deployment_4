# SUBNET 1
resource "aws_subnet" "pub_subnet1" {
  cidr_block              = "172.19.0.0/18"
  vpc_id                  = aws_vpc.dep4-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" : "dep4PubA"
  }
}

# SUBNET 2
resource "aws_subnet" "pri_subnet1" {
  cidr_block              = "172.19.64.0/18"
  vpc_id                  = aws_vpc.dep4-vpc.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    "Name" : "dep4PriA"
  }
}

# SUBNET 3
resource "aws_subnet" "pub_subnet2" {
  cidr_block              = "172.19.128.0/18"
  vpc_id                  = aws_vpc.dep4-vpc.id
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" : "dep4PubB"
  }
}

# SUBNET 4
resource "aws_subnet" "pri_subnet2" {
  cidr_block              = "172.19.192.0/18"
  vpc_id                  = aws_vpc.dep4-vpc.id
  map_public_ip_on_launch = "false"
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    "Name" : "dep4PriB"
  }
}