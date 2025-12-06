terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.4.0"
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = ">= 4.0.0"
  name = "${var.cluster_name}-vpc"
  cidr = "10.0.0.0/16"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)
  public_subnets  = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
  private_subnets = ["10.0.11.0/24","10.0.12.0/24","10.0.13.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

data "aws_availability_zones" "available" {}

resource "aws_ecr_repository" "app" {
  name = var.ecr_repo_name
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration { scan_on_push = true }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 18.0.0"
  cluster_name = var.cluster_name
  cluster_version = "1.27"
  vpc_id = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
  tags = {
    Owner = "devops-team"
  }
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_id
}
