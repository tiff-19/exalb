resource "aws_instance" "web-server1" {
  ami               = var.AMIS[var.AWS_REGION]
  instance_type     = "t2.micro"
  key_name          = "webserver-key"
  security_groups   = [aws_security_group.terraform-instance-sg.id]
  subnet_id         = aws_subnet.terraform-public-1.id
  user_data         = "#! /bin/bash\nsudo apt update\nsudo apt install nginx -y\necho '<h1><center>welcome to my website from $(hostname -f)</center></h1>' > /var/www/html/index.html"

  tags = {
    Name = "webserver-1"	
  }
}

resource "aws_instance" "web-server2" {
  ami               = var.AMIS[var.AWS_REGION]
  instance_type     = "t2.micro"
  key_name          = "webserver-key"
  security_groups   = [aws_security_group.terraform-instance-sg.id]
  subnet_id         = aws_subnet.terraform-public-1.id
  user_data         = "#! /bin/bash\nsudo apt update\nsudo apt install nginx -y\necho '<h1><center>welcome to my website from $(hostname -f)</center></h1>' > /var/www/html/index.html"

  tags = {
    Name = "webserver-2"	
  }
}