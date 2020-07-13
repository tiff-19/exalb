# module "ec2_cluster" {
#   source                 = "terraform-aws-modules/ec2-instance/aws"
#   version                = "~> 2.0"

#   name                   = "terraform-cluster"
#   instance_count         = 4

#   ami                    = var.AMIS[var.AWS_REGION]
#   instance_type          = "t2.micro"
#   key_name               = "webserver-key"
#   monitoring             = true
#   vpc_security_group_ids = [aws_security_group.terraform-instance-sg.id]
#   subnet_id              = aws_subnet.terraform-puublic-1.id
#   user_data              = "#! /bin/bash\nsudo apt update\nsudo apt install nginx -y\necho '<h1><center>welcome to my website from $(hostname -f)</center></h1>' > /var/www/html/index.html"

# }