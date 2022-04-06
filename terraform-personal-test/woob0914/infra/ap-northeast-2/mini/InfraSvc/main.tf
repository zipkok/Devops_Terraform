
# ==================================================================
# Instance Security Group ==========================================
# ==================================================================
resource "aws_security_group" "instance_sg" {
  vpc_id = data.aws_vpc.default.id
  name   = "infra_sg"
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
resource "aws_network_interface" "infraSrv" {
  subnet_id       = "subnet-0bb6b78a4fb764f01"
  security_groups = [aws_security_group.instance_sg.id]

  // attachment {
  //   instance     = aws_instance.infraSrv.id
  //   device_index = 1
  // }
}

resource "aws_instance" "infraSrv" {
  ami           = "ami-033a6a056910d1137"
  instance_type = "t3.micro"

  tags = {
    Name    = "infraSrv"
    Service = "meta"
  }

  network_interface {
    network_interface_id = aws_network_interface.infraSrv.id
    device_index         = 0
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