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

output "public_ip" {
  value       = "aws_instance.example.public_ip"
  description = "The Public IP address of the web server"
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