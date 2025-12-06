terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
provider "aws" {
  region = var.aws_region
}
resource "aws_ecr_repository" "app" {
  name = var.ecr_repo_name
}
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = ">= 18.0.0"
  cluster_name = var.cluster_name
  cluster_version = "1.27"
  subnets = var.private_subnets
  vpc_id  = var.vpc_id
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}
