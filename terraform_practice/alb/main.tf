resource "aws_instance" "web" {
  ami           = "ami-033a6a056910d1137"
  instance_type = "t3.micro"

  tags = {
    Name = "FrontEnd"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_security_group" "alb" {
  name = "terraform-example-alb"

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
  name               = "terraform-alb"
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
# Step 3/4 of AWS ELB (Target_Group)
resource "aws_lb_target_group" "target_group" {
  name     = "terraform-tg-example"
  port     = 80
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
# Step 4/4 of AWS ELB (Listener_rule)
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
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

# =========================================================
# Attachment EC2 Instasnce to TargetGroup
resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.web.id
  port             = 80
}
