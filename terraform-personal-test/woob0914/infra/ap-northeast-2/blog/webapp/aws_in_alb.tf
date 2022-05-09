# =========================================================
# Step 1/4 of AWS ELB (ALB)
resource "aws_lb" "rsc_blog_inalb" {
  name               = "${var.alb_name}-in"
  load_balancer_type = "application"
  internal           = true
  subnets            = ["subnet-095041c85bc79d384", "subnet-05a0afbf6beb61357"]

  security_groups = [aws_security_group.rsc_elb_any_80.id]
}

# =========================================================
# Step 2/4 of AWS ELB (Listener)
resource "aws_lb_listener" "rsc_blog_inalb_listener" {
  load_balancer_arn = aws_lb.rsc_blog_alb.arn
  port              = 80
  protocol          = "HTTP"

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
resource "aws_lb_target_group" "rsc_blog_inalb_target_group" {
  name     = var.alb_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-0546f3f1c47f1f95e"

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
resource "aws_lb_listener_rule" "rsc_blog_inalb_listener_rule" {
  listener_arn = aws_lb_listener.rsc_blog_alb_listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rsc_blog_alb_target_group.arn
  }
}

resource "aws_lb_target_group_attachment" "rsc_blog_inalb_target_group_attachment" {
  count            = length(data.terraform_remote_state.instance_id.outputs.aws_instance_id)
  target_group_arn = aws_lb_target_group.rsc_blog_alb_target_group.arn
  target_id        = data.terraform_remote_state.instance_id.outputs.aws_instance_id[count.index]
  port             = 80
}