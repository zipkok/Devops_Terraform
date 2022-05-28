
# =========================================================
# Step 1/4 of AWS ELB (ALB)
resource "aws_lb" "mdu_aws_lb" {
  name               = var.alb_lb_info.name
  load_balancer_type = var.alb_lb_info.load_balancer_type
  security_groups    = var.alb_security_groups
  subnets            = var.vpc_ec2_subnet_id
}

# =========================================================
# Step 2/4 of AWS ELB (Listener)
resource "aws_lb_listener" "mdu_aws_lb_listener" {
  load_balancer_arn = aws_lb.mdu_aws_lb.arn
  port              = var.alb_lb_info.client_to_alb_port
  protocol          = var.alb_lb_info.client_to_alb_protocol

  # 기본 값으로 단순한 404 페이지 오류를 반환합니다.
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}


# =========================================================
# Step 3/4 of AWS ELB (Target_Group)
resource "aws_lb_target_group" "mdu_aws_lb_target_group" {
  name     = var.alb_lb_info.name
  port     = var.alb_lb_info.alb_to_target_group_port     # 80
  protocol = var.alb_lb_info.alb_to_target_group_protocol # "HTTP"
  vpc_id   = var.vpc_id                                   # "vpc-0546f3f1c47f1f95e"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
  }
}

# =========================================================
# Step 4/4 of AWS ELB (Listener_rule)
resource "aws_lb_listener_rule" "mdu_aws_lb_listener_rule" {
  listener_arn = aws_lb_listener.mdu_aws_lb_listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mdu_aws_lb_target_group.arn
  }
}

