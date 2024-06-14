provider "aws" {
  region = "us-east-1"
}

variable vpc_cidr_block {}
variable private_subnet_cidr_blocks {}
variable public_subnet_cidr_blocks {}

# data "aws_availability_zones" "azs" {}

module "myapp-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "myapp-vpc"
  cidr = var.vpc_cidr_block
  private_subnets = var.private_subnet_cidr_blocks
  public_subnets = var.public_subnet_cidr_blocks
  azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1f"]

  enable_nat_gateway = true
  single_nat_gateway = true 
  enable_dns_hostnames = true 

  tags = {
    "kubernetes.io/cluster/myapp-eks-tfcluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-tfcluster" = "shared"
    "kubernetes.io/role/elb" = 1 
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/myapp-eks-tfcluster" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}