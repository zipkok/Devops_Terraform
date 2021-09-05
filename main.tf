provider "aws" {
  region = "us-east-2"
}

variable "server_port" {
  description = "The port the Server will use for HTTP Requests"
  type        = number
  default     = 8080
}

resource "aws_instance" "example" {
  ami                    = "ami-00399ec92321828f5"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, world" > index.html
                # nohup busybox httpd -f -p 8080 &
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

  tags = {
    Name    = "terraform-example",
    woobeom = "woobeom",
    im      = "im"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    # from_port   = 8080
    # to_port     = 8080
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "example" {
  name          = "aws_launch_configuration"
  image_id      = "ami-00399ec92321828f5"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
                #!/bin/bash
                echo "Hello, world" > index.html
                # nohup busybox httpd -f -p 8080 &
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

  # ASG 시작 구성 사용 시 필수
  # terraform 기본 구조: 삭제 후 생성
  # create_before_destory = true: 생성 후 삭제로 변경됨
  lifecycle {
    create_before_destroy = true
  }
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}


resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  # ELB 연결 (optional)
  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  # Instance Min/Max Count
  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }
}

# ALB 생성 과정:  SG 생성 -> ALB 생성 -> Listener 생성 -> Rule 생성 -> TargetGroup 생성
# ALB의 SG 생성
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


# ALB 생성
resource "aws_lb" "example" {
  name               = "terraform-asg-example"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.alb.id]
}

# Listener 생성
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

# Target Group 생성
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

# Listenr Rule 생성
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority    = 100

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