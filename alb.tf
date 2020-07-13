resource "aws_lb" "terraform-alb" {
  name               = "terraform-clb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.terraform-lb-sg.id]
  subnets            = [aws_subnet.terraform-public-1.id,aws_subnet.terraform-public-2.id, aws_subnet.terraform-public-3.id]

  enable_deletion_protection = false

  tags = {
    Environment = "staging"
  }
}

resource "aws_lb_target_group" "terraform-tgalb" {
  name     = "terraform-tgalb"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terraform-vpc.id
}

resource "aws_lb_listener" "terraform-listener" {
  load_balancer_arn = aws_lb.terraform-alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terraform-tgalb.arn
  }
}