terraform {
  /* backend "s3" {
    bucket = "Github-action-Bucket"
    key    = "terraform.tfstate"
    region = "us-west-1"
  } */
  #required_version = "1.5.4"    # Here is the terraform block which was introduced from version 0.13 and upwards
  required_providers {
    aws = { #Argument opens with =, while block opens with {
      source = "hashicorp/aws"
      #version = "~> 5.30.0"
      version = ">= 5.58.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

