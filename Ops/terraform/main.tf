terraform {
  required_providers {
    aws ={
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
   region = "ca-central-1"
}


resource "aws_iam_role" "test_role" {
  name = "Terraform-GKJ"
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17"
    "Statement": [
     {
       "Effect" "Allow",
       "Prinicipal":{
           "Service": "ec2.amazonaws.com"
           },
           "Action": "sts:Assumerole"
     }
    ]
}

EOF
    
    }

resource "aws_iam_role_policy_attachment" "test_attachment" {
    role = aws_iam_role.test_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "test_role" {
    name = "Terraform-GKJ"
  
}

resource "aws_security_group" "Jenkins-sg" {
  name = "Jenkins-securitygroup"
  description = "open 22,443,80,8080,9000,3000"


#This single ingress rule will allow traffic for all specified port
  ingress = [
    for port in [22,443,80,8080,9000,3000]: {
        description = "TLS from VPC"
        from_port = port
        to_port = port
        protcol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []
        prefix_list_ids = []
        security_groups = []
        self = flase

    }
  ]
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
   }

   tags = {
    Name = "Jenkins-sg"
   }
}

   resource "aws_instance" "app"{
    ami = "ami-0abac8735a38475db"
    instance_type = "t3-medium"
    key_name = "mac"
    vpc_security_group_ids = [aws_security_group.Jenkins-sg.id]
    user_data = templatefile("./install_tools.sh",{})
    iam_instance_profile = aws_iam_instance_profile.test_role.name

    tags ={
        Name = "Jenkins-argo"
    }

    root_block_device {
        volume_size = 30 
    }
   }