provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    # 생성한 버킷 이름으로 변경
    bucket = "woobeom-state"
    #key    = "global/s3/terraform.tfstate"
    key    = "stage/services/webserver-cluster/terraform.tfstate"
    region = "us-east-1"

    # 생성한 다이나모DB 테이블 이름으로 변경
    dynamodb_table = "woobeom-state-locks"
    encrypt        = true
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = "woobeom-state"
    key    = "stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

data "template_file" "user_data" {
  template = file("user-data.sh")

  vars = {
    server_port = var.server_port
    db_address  = data.terraform_remote_state.db.outputs.address
    db_port     = data.terraform_remote_state.db.outputs.port
  }
}

resource "aws_instance" "example" {
  ami                    = "ami-09e67e426f25ce0d7"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
                #!/bin/bash
                echo " Hello, world " > index.html
                echo " $ { data.terraform_remote_state.db.outputs.address } > > index.html
echo "${data.terraform_remote_state.db.outputs.port} >> index.html
                # nohup busybox httpd -f -p 8080 &
                nohup busybox httpd -f -p ${var.server_port} &
                EOF

  tags = {
    Name    = " terraform-example ",
    woobeom = " woobeom ",
    im      = " im "
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
  image_id      = "ami-09e67e426f25ce0d7"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.instance.id]

  user_data = data.template_file.user_data.rendered

  # ASG 시작 구성 사용 시 필수
  # terraform 기본 구조: 삭제 후 생성
  # create_before_destory = true: 생성 후 삭제로 변경됨
  /* lifecycle {
    create_before_destroy = true
  } */
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}


resource "aws_autoscaling_group" "example2" {
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
    value               = "terraform-asg-example2"
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
      message_body = "404:page not found"
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