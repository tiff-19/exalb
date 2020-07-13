resource "aws_launch_configuration" "terraform-as-conf" {
    name                    = "terraform_web_config"
    image_id                = var.AMIS[var.AWS_REGION]
    instance_type           = "t2.micro"
    key_name                = "webserver-key"
    security_groups         = [aws_security_group.terraform-instance-sg.id]
    user_data               = "#! /bin/bash\nsudo apt update\nsudo apt install net-tools nginx -y\necho '<h1><center>welcome to my website from </br></center></h1>' > /var/www/html/index.html"
}

resource "aws_autoscaling_group" "terraform-asg" {
  name                      = "terraform-asg"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.terraform-as-conf.name
  vpc_zone_identifier       = [aws_subnet.terraform-public-1.id, aws_subnet.terraform-public-2.id, aws_subnet.terraform-public-3.id]
#  load_balancers            = [aws_elb.terraform-elb.name]
  target_group_arns         = [aws_lb_target_group.terraform-tgalb.arn]
  tag {
    key                 = "Name"
    value               = "terraform-asg"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "terraform-scaleout" {
  name                   = "terraform-scaleout"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
}

resource "aws_cloudwatch_metric_alarm" "alarm-so" {
  alarm_name          = "alarm-so"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "60"
  statistic           = "Average"
  threshold           = "40"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.terraform-scaleout.arn]
}

resource "aws_autoscaling_policy" "terraform-scalein" {
  name                   = "terraform-scalein"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 30
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
}

resource "aws_cloudwatch_metric_alarm" "alarm-si" {
  alarm_name          = "alarm-so"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/AutoScaling"
  period              = "60"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.terraform-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.terraform-scalein.arn]
}

resource "aws_autoscaling_policy" "terraform-tts" {
  name                   = "terraform-tts"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.terraform-asg.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
    }
  
  target_value = 40.0
  }
}