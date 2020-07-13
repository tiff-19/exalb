resource "aws_security_group" "terraform-instance-sg"{
    vpc_id      = aws_vpc.terraform-vpc.id
    name        = "terraformInstanceSg"
    description = "security group for instance"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]  
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        #security_groups = [aws_security_group.terraform-lb-sg.id]
    }

    tags = {
        Name = "terraformInstanceSg"
    }
}

resource "aws_security_group" "terraform-lb-sg"{
    vpc_id      = aws_vpc.terraform-vpc.id
    name        = "terraformLbSg"
    description = "security group for load balancer"

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]  
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "terraformLbSg"
    }
}