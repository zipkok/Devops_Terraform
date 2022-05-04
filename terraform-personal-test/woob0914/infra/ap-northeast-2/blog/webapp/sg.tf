resource "aws_security_group" "vpc-0546f3f1c47f1f95e-blog_db_sg" {
  name        = "blog_db_sg"
  description = "security_group_describe"
  vpc_id      = "vpc-0546f3f1c47f1f95e"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["sg-065c45825bc904bcf"]
    self            = false
  }


  egress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = ["sg-065c45825bc904bcf"]
    self            = false
  }

  tags {
    Creator = "Woobeom"
    Name    = "blog_db_sg"
  }
}

resource "aws_security_group" "vpc-0546f3f1c47f1f95e-blog_back_sg" {
  name        = "blog_back_sg"
  description = "security_group_describe"
  vpc_id      = "vpc-0546f3f1c47f1f95e"

  ingress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["sg-084a08cc5928568e8"]
    self            = false
  }

  ingress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = ["sg-015e8701316e06c47"]
    self            = false
  }


  egress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = ["sg-084a08cc5928568e8"]
    self            = false
  }

  egress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["sg-015e8701316e06c47"]
    self            = false
  }

  tags {
    Name    = "blog_back_sg"
    Creator = "Woobeom"
  }
}

resource "aws_security_group" "vpc-0546f3f1c47f1f95e-blog_front_sg" {
  name        = "blog_front_sg"
  description = "security_group_describe"
  vpc_id      = "vpc-0546f3f1c47f1f95e"

  ingress {
    from_port       = 1025
    to_port         = 65535
    protocol        = "tcp"
    security_groups = ["sg-065c45825bc904bcf"]
    self            = false
  }


  egress {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["sg-065c45825bc904bcf"]
    self            = false
  }

  tags {
    Creator = "Woobeom"
    Name    = "blog_front_sg"
  }
}

resource "aws_security_group" "vpc-0546f3f1c47f1f95e-launch-wizard-1" {
  name        = "launch-wizard-1"
  description = "launch-wizard-1 created 2022-05-04T10:33:13.104Z"
  vpc_id      = "vpc-0546f3f1c47f1f95e"

  ingress {
    from_port   = 22
    to_port     = 22
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

resource "aws_security_group" "vpc-0546f3f1c47f1f95e-default" {
  name        = "default"
  description = "default VPC security group"
  vpc_id      = "vpc-0546f3f1c47f1f95e"


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "vpc-0546f3f1c47f1f95e-ELB-ANY-80-443" {
  name        = "ELB-ANY-80-443"
  description = "ELB-ANY-80-443"
  vpc_id      = "vpc-0546f3f1c47f1f95e"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

resource "aws_security_group" "vpc-0546f3f1c47f1f95e-ELB-Intra-80-443" {
  name        = "ELB-Intra-80-443"
  description = "ELB-Intra-80-443"
  vpc_id      = "vpc-0546f3f1c47f1f95e"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["172.0.0.0/8"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}