variable "aws_region" {
  description = "AWS region"
  type = string
  default = "ca-central-1"
}

variable "ecr_repo_name" {
  description = "Name for ECR repository"
  type = string
  default = "Mutiverse"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type = string
  default = "Mutiverse-cluster"
}
