# This would create just a VPC
resource "aws_vpc" "wp_vpc" {
  cidr_block = "172.0.0.0/16"
  #cidr_block = ["172.0.0.0/16", "172.0.1.0/16"]
  tags = {
    Name = "wp_vpc"
  }
}


# Create an Internet gateway here
resource "aws_internet_gateway" "wp_igw" {
  vpc_id = aws_vpc.wp_vpc.id

  tags = {
    Name = "wp_igw"
  }
}

