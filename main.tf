provider "aws" {
    region = "ap-south-1"
}

resource "aws_launch_template" "home_template" {
    name = "home-template"
    image_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = var.security_grp 
    user_data = filebase64("user-data.sh")
    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "home-template" 
      }
    }
}

resource "aws_autoscaling_group" "auto_grp"{
     max_size = 3
     min_size = 2
     desired_capacity = 2
     health_check_type = "ELB"
     health_check_grace_period = 300
     target_group_arns = [aws_lb_target_group.tgt_home.arn]
     vpc_zone_identifier = var.subnet_ids
     launch_template {
       id = aws_launch_template.home_template.id
       version = "$Latest"
     }
}

resource "aws_lb_target_group" "tgt_home" {
    name = "tgt-home"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id

    health_check {
      enabled = true
      interval = 30
      path = "/"
      port = "traffic-port"
      protocol = "HTTP"
      timeout = 5
      healthy_threshold = 2
      unhealthy_threshold = 2
      matcher = "200"
    }

    tags = {
        Name = "tgt-home"
    } 
}

resource "aws_lb" "lb_home" {
    name = "lb-home"
    internal = false
    load_balancer_type = "application"
    security_groups = var.security_grp
    subnets = var.subnet_ids
}

resource "aws_lb_listener" "home_lr" {
    load_balancer_arn = aws_lb.lb_home.arn
    port = 80
    protocol = "HTTP"

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.tgt_home.arn
    }
}

module "" {
  
}

