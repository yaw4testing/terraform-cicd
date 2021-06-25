terraform {
  required_providers{
      aws = {
          source  = "hashicorp/aws"
         version = "~> 3.27"
         }
     }
}
provider "aws" {
    profile = "default"
    region  = var.aws_region
    }

data "aws_availability_zones" "available"{}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "TDemos"
  cidr = var.cidr_block

  azs             = slice(data.aws_availability_zones.available.names,0,var.subnet_count)
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = false
  

  tags = {
    Environment = "DevOps"
    }

}




