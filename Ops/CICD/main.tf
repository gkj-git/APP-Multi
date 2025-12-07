resource "aws_instance" "CICD" {
    ami =
    instance_type = 
    key_name = 
    vpc_security_group_ids = 
    user_data = 
    tags = {
      Name = "CICD-instance"
    }
}

resource "aws_security_group" "CICD-sg" {
    name = "CICD SG"
    description = "allow access on port 80 and 22 and 443"

    ingress = [
        for port in [22,80,443] : {
            description = "TLS from VPC"
            from_port = port
            to_port = port
            protocol = "tcp"
            cidr_blocks = [ "0.0.0.0/0" ]
            ipv6_cidr_blocks = []
            prefix_list_ids = []
            security_groups = []
            self = false
        }
    ]


    egress {
        from_port = 0 
        to_port = 0 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = []     

        }
    tags = {
        Nmae = "ec2-sg"
    }
}