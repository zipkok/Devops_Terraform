# =========================================================
# Security Group 생성 (ASG)
resource "aws_security_group" "instance" {
  name = var.instance_security_group_name

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# =========================================================
# Security Group 생성 (ELB)
resource "aws_security_group" "alb" {
  name = var.alb_security_group_name

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# =========================================================
# Step 1/4 of AWS ELB (ALB)
resource "aws_lb" "example" {
  name               = var.alb_name
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids

  security_groups = [aws_security_group.alb.id]
}

# =========================================================
# Step 2/4 of AWS ELB (Listener)
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
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
# Step 3/4 of AWS ELB (Listener_rule)
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}


# =========================================================
# Step 4/4 of AWS ELB (Target_Group)
resource "aws_lb_target_group" "asg" {
  name     = "terraform-asg-example"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# =========================================================
# AWS Launch Template
resource "aws_launch_configuration" "example" {

  # ami -> image_id
  image_id      = "ami-0454bb2fefc7de534"
  instance_type = "t2.micro"

  # vpc_security_group_ids -> security_groups
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  # Terraform은 기본적으로 리소스 변경 시 삭제 후 생성을 함.
  # Launch_Template 변경 시 교체 리소스를 먼저 생성하고 기존 리소스를 삭제함.
  lifecycle {
    create_before_destroy = true
  }

}

# =========================================================
# AWS AutoScale Group
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name

  # ELB 연결
  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"
  
  min_size          = 2
  max_size          = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

  # SubnetID를 조회하여 ASG에 연결함.
  vpc_zone_identifier = data.aws_subnet_ids.default.ids
}
