# INPUT VARIABLES
# AWS Region
# INPUT CIDR
#variable "cidr" {
#type    = list(any)
#default = ["172.0.0.0/19", "172.0.0.0/19"]
#}
variable "aws_region" {
  description = "This is the region where the AWS resource would be created"
  type        = string
  default     = "us-west-1"
}
#variable "AZ" {
#description = "This are the availability zones to choose from"
#type        = list(any)
#default     = ["us-west-1b", "us-west1c"]

#}

# AWS EC2 Instance Type
variable "instance_type" {
  description = "EC2 Instance type"
  type        = string
  default     = "t2.medium"
}


# AWS EC2 Instance Key Pair
variable "key-name" {
  description = "Key pair that needs to be associated to EC2 instance"
  type        = string
  default     = "calkeypair"

}

variable "instance_type_list" {
  description = "EC2 instance type"
  type        = list(string)
  default     = ["t2.micro", "t3.micro", "t2.medium"]
}

variable "availability_zone" {
  description = "EC2 availability zone"
  type        = list(string)
  default     = ["us-west-1b", "us-west-1c"]
}

variable "username" {
  description = "DB username"
  default     = "admin"
}

variable "dbname" {
  description = "DB Name"
  default     = "wordpressdb"
}

variable "password" {
  description = "DB password"
  default     = "password"
}




/*
variable "public_subnet" {
  description = "VPC Public Subnet"
  type        = list(string)
  default     = ["172.0.1.0/24", "172.0.2.0/24"]
}


#VPC Private Subnets
variable "private_subnet" {
  description = "VPC Private Subnet"
  type        = list(string)
  default     = ["172.0.11.0/24", "172.0.12.0/24"]
}

#VPC Database subnet
variable "database_subnet" {
  description = "VPC Database Subnet"
  type        = list(string)
  default     = ["172.0.21.0/24", "172.0.22.0/24"]
}
*/
