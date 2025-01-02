resource "aws_launch_template" "lt" {
  name = "${var.project_name}-${var.tier}-launch-template"

  image_id          = var.custom_ami_id  # Specify your custom AMI ID
  instance_type     = var.instance_type  # e.g., "t3.micro"
  vpc_security_group_ids = [var.app_tier_sg_id]  # Attach the app tier SG

  iam_instance_profile {
    arn = var.ec2_instance_profile_arn
  }

  user_data = base64encode(var.user_data)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name = "${var.project_name}-${var.tier}-asg"
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.subnet_ids  # List of subnet IDs (private or public)
  launch_template {
    id = aws_launch_template.lt.id
    version             = "$Latest"
  }

  health_check_type        = "EC2"
  health_check_grace_period = 200
  force_delete             = true
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.tier}-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "lb" {
  name               = "${var.project_name}-${var.tier}-lb"
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.subnet_ids

  enable_cross_zone_load_balancing = true
  tags = {
    Name = "${var.project_name}-${var.tier}-lb"
  }
}

resource "aws_lb_target_group" "target_group" {
  name     = "${var.project_name}-${var.tier}-tg"
  port     = var.ingress_port
  protocol = var.ingress_protocol
  vpc_id   = var.vpc_id
  health_check {
    path                = "/health"
    port                = var.ingress_port
    protocol            = "HTTP"
    timeout             = 5
  }

}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_autoscaling_attachment" "tg_attach" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}
#added a comment