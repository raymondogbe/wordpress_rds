

# Define public and private subnets 

resource "aws_subnet" "public_subnet1" {

  vpc_id = aws_vpc.wp_vpc.id

  cidr_block = "172.0.1.0/24"

  availability_zone = "us-west-1b"

  map_public_ip_on_launch = true

}
resource "aws_subnet" "public_subnet2" {

  vpc_id = aws_vpc.wp_vpc.id

  cidr_block = "172.0.2.0/24"

  availability_zone = "us-west-1c"

  map_public_ip_on_launch = true

}




resource "aws_subnet" "private_subnet1" {

  vpc_id = aws_vpc.wp_vpc.id

  cidr_block = "172.0.3.0/24"

  availability_zone = "us-west-1b"

}

resource "aws_subnet" "private_subnet2" {

  vpc_id = aws_vpc.wp_vpc.id

  cidr_block = "172.0.4.0/24"

  availability_zone = "us-west-1c"

}



#rds subnet
resource "aws_db_subnet_group" "wordpress_db_subnet_group" {
  name = "wordpress-db-subnet-group"
  #subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "wordpress-db-subnet-group"
  }
}



#redis subnet
resource "aws_elasticache_subnet_group" "wp_redis_subnet_group" {
  name       = "wp-redis-subnet-group"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "wp-redis-subnet-group"
  }
}













/*
#PUBLIC SUBNET = 1 and 3
#PRIVATE SUBNET   = 2 and 4

# Create a Subnet
resource "aws_subnet" "vpc_prod_subnet1" {
  vpc_id                  = aws_vpc.vpc_prod.id
  cidr_block              = "172.0.0.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1b"
  #availability_zone = var.AZ[count.index]
  #count             = 2
  tags = {
    Name                          = "vpc_prod_subnet1"
    "kubernetes.io/role/elb"      = "1"
    "kubernetes.io/cluster/erply" = "owned"
  }
}

resource "aws_subnet" "vpc_prod_subnet2" {
  vpc_id                  = aws_vpc.vpc_prod.id
  cidr_block              = "172.0.32.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1c"
  #availability_zone = var.AZ[count.index]
  #count             = 2

  tags = {
    Name                              = "vpc_prod_subnet2"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/erply"     = "owned"
  }
}

resource "aws_subnet" "vpc_prod_subnet3" {
  vpc_id                  = aws_vpc.vpc_prod.id
  cidr_block              = "172.0.64.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1b"
  #availability_zone = var.AZ[count.index]
  #count             = 2

  tags = {
    Name                          = "vpc_prod_subnet3"
    "kubernetes.io/role/elb"      = "1"
    "kubernetes.io/cluster/erply" = "owned"
  }
}

resource "aws_subnet" "vpc_prod_subnet4" {
  vpc_id                  = aws_vpc.vpc_prod.id
  cidr_block              = "172.0.96.0/19"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-1c"
  #availability_zone = var.AZ[count.index]
  #count             = 2

  tags = {
    Name                              = "vpc_prod_subnet4"
    "kubernetes.io/role/internal-elb" = "1"
    "kubernetes.io/cluster/erply"     = "owned"
  }
}
*/