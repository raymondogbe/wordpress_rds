resource "aws_nat_gateway" "nat_gate" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet1.id #, aws_subnet.public_subnet2.id]

  tags = {
    Name = "gw NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.wp_igw]
}

############################
resource "aws_eip" "nat" {
  domain = "vpc"
  tags = {
    Name = "nat"
  }
}

/*resource "aws_nat_gateway" "k8s-nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.vpc_prod_subnet1.id

  tags = {
    Name = "k8s-nat"
  }

  depends_on = [aws_internet_gateway.vpc_prod_igw]
}
############################
*/

