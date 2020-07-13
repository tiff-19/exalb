resource "aws_elb" "terraform-elb" {
    name            = "terraform-elb"
    subnets         = [aws_subnet.terraform-public-1.id, aws_subnet.terraform-public-2.id, aws_subnet.terraform-public-3.id]
    security_groups = [aws_security_group.terraform-lb-sg.id]

    listener {
        instance_port       = 8000
        instance_protocol   = "HTTP"
        lb_port             = 80
        lb_protocol         = "http"
    }

    health_check {
        healthy_threshold       = 2
        unhealthy_threshold     = 3
        timeout                 = 3
        target                  = "HTTP:80/"
        interval                = 30
    }

#    instances                   = [aws_instance.web-server1.id, aws_instance.web-server2.id]
    cross_zone_load_balancing   = true
    connection_draining         = true
    connection_draining_timeout = 400

    tags = {
        Name = "terraform-elb"
    }
}