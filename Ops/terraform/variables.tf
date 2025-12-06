variable "aws_region" { 
    type = string 
    }
variable "ecr_repo_name" { 
    type = string 
    }
variable "cluster_name" { 
    type = string 
    }
variable "vpc_id" { 
    type = string 
    }
variable "private_subnets" { 
    type = list(string)
     }
