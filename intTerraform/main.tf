# VARIABLES
variable "aws_access_key" {}
variable "aws_secret_key" {}

# PROVIDER
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
  
}


# VPC
resource "aws_vpc" "dep4-vpc" {
  cidr_block           = "172.19.0.0/16"
  enable_dns_hostnames = "true"
  tags = {
    "Name" : "dep4-VPC"
  }
}

# ELASTIC IP 
resource "aws_eip" "nat_eip_prob" {
  vpc = true

}


# DATA
data "aws_availability_zones" "available" {
  state = "available"
}


#output "instance01_ip" {
#  value = aws_instance.web_server01.public_ip
#  
#}

#output "instance02_ip" {
#  value = aws_instance.web_server02.private_ip
#  
#}