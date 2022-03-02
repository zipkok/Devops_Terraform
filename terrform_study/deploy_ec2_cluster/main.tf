# =========================================================
# Security Group 생성
resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
  aws_launch_configuration = aws_launch_configuration.example.name

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "terraform-asg-example"
    propagate_at_launch = true
  }

  # SubnetID를 조회하여 ASG에 연결함.
  vpc_zone_identifier = data.aws_subnet_ids.default.ids
}



