# Define route table for public subnet 

resource "aws_route_table" "public_route_table" {

  vpc_id = aws_vpc.wp_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.wp_igw.id

  }



  tags = {

    Name = "Public"

  }

}




# Associate public subnet with public route table 

resource "aws_route_table_association" "public_route_assoc1" {

  subnet_id = aws_subnet.public_subnet1.id

  route_table_id = aws_route_table.public_route_table.id

}
resource "aws_route_table_association" "public_route_assoc2" {

  subnet_id = aws_subnet.public_subnet2.id

  route_table_id = aws_route_table.public_route_table.id

}


#DEFINE ROUTE TABLE FOR PRIVATE SUBNET
resource "aws_route_table" "private_route_table" {

  vpc_id = aws_vpc.wp_vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    #gateway_id = aws_internet_gateway.wp_igw.id
    nat_gateway_id = aws_nat_gateway.nat_gate.id

  }

  tags = {

    Name = "Private"

  }

}

# Associate public subnet with public route table 

resource "aws_route_table_association" "private_route_assoc1" {

  subnet_id = aws_subnet.private_subnet1.id

  route_table_id = aws_route_table.private_route_table.id

}
resource "aws_route_table_association" "private_route_assoc2" {

  subnet_id = aws_subnet.private_subnet2.id

  route_table_id = aws_route_table.private_route_table.id

}