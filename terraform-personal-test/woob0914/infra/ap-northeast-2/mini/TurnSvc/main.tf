
# ==================================================================
# Instance Security Group ==========================================
# ==================================================================
resource "aws_security_group" "instance_sg" {
  vpc_id = data.aws_vpc.default.id
  name   = "instance_sg"
}

resource "aws_security_group_rule" "alb_ingress_rule" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_sg.id
}

resource "aws_security_group_rule" "alb_egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.instance_sg.id
}


# ==================================================================
# AWS Instance =====================================================
# ==================================================================
resource "aws_eip" "mediaSrv" {
  instance = aws_instance.mediaSrv.id
}

resource "aws_instance" "mediaSrv" {
  ami           = "ami-033a6a056910d1137"
  instance_type = "t3.micro"

  tags = {
    Name    = "mediaSrv"
    Service = "meta"
  }

  root_block_device {
    volume_size = 30
  }
}


# ==================================================================
# Get VPC_ID =======================================================
# ==================================================================
data "aws_vpc" "default" {
  default = true
}

# ==================================================================
# GET Subnet_Ids ===================================================
# ==================================================================
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}