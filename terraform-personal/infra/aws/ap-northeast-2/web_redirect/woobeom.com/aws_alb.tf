# =========================================================
# Step 1/4 of AWS ELB (ALB)
resource "aws_lb" "rsc_aws_alb" {
  name               = var.alb_info.alb_name
  load_balancer_type = var.alb_info.load_balancer_type
  subnets            = var.subnet_ids

  security_groups = [data.terraform_remote_state.security_group_id.outputs.alb_security_group_id[0]]
}

# =========================================================
# Step 2/4 of AWS ELB (Listener)
resource "aws_lb_listener" "rsc_aws_alb_listener" {
  load_balancer_arn = aws_lb.rsc_aws_alb.arn
  port              = var.alb_info.user_to_alb_port
  protocol          = var.alb_info.user_to_alb_protocol

  # 기본 값으로 단순한 404 페이지 오류를 반환합니다.
  default_action {
    type = "redirect"

    redirect {
      port        = var.alb_info.redirect_port
      protocol    = var.alb_info.redirect_protocol
      status_code = var.alb_info.redirect_status_code
      host        = var.alb_info.redirect_host
    }
  }
}