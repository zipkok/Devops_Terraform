# =================================================================================
# Security Group - [Blog] Default SG ==============================================
# =================================================================================
resource "aws_security_group" "default_security_group" {
  name        = var.security_group_config["ec2_sg"].config.name
  description = var.security_group_config["ec2_sg"].config.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.security_group_config["ec2_sg"].config.name
    Team        = var.common_security_group_tags.Team
    Creator     = var.common_security_group_tags.Creator
    IsTerraform = var.common_security_group_tags.IsTerraform
  }
}

resource "aws_security_group_rule" "default_security_group_ingress_1" {
  type              = var.security_group_config["ec2_sg"].ingress_1.type
  from_port         = var.security_group_config["ec2_sg"].ingress_1.from_port
  to_port           = var.security_group_config["ec2_sg"].ingress_1.to_port
  protocol          = var.security_group_config["ec2_sg"].ingress_1.protocol
  cidr_blocks       = [var.security_group_config["ec2_sg"].ingress_1.cidr_blocks]
  security_group_id = aws_security_group.default_security_group.id
}

# =================================================================================
# Security Group - [Blog] EC2 SG ==================================================
# =================================================================================
resource "aws_security_group" "ec2_security_group" {
  name        = var.security_group_config["default_sg"].config.name
  description = var.security_group_config["default_sg"].config.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.security_group_config["default_sg"].config.name
    Team        = var.common_security_group_tags.Team
    Creator     = var.common_security_group_tags.Creator
    IsTerraform = var.common_security_group_tags.IsTerraform
  }
}

resource "aws_security_group_rule" "ec2_security_group_ingress_1" {
  type              = var.security_group_config["default_sg"].ingress_1.type
  from_port         = var.security_group_config["default_sg"].ingress_1.from_port
  to_port           = var.security_group_config["default_sg"].ingress_1.to_port
  protocol          = var.security_group_config["default_sg"].ingress_1.protocol
  cidr_blocks       = [var.security_group_config["default_sg"].ingress_1.cidr_blocks]
  security_group_id = aws_security_group.ec2_security_group.id
}

# =================================================================================
# Security Group - [TEST] EC2 SG ==================================================
# =================================================================================
resource "aws_security_group" "test_security_group" {
  name        = var.security_group_config["test_sg"].config.name
  description = var.security_group_config["test_sg"].config.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.security_group_config["test_sg"].config.name
    Team        = var.common_security_group_tags.Team
    Creator     = var.common_security_group_tags.Creator
    IsTerraform = var.common_security_group_tags.IsTerraform
  }
}

resource "aws_security_group_rule" "test_security_group_ingress_1" {
  type              = var.security_group_config["test_sg"].ingress_1.type
  from_port         = var.security_group_config["test_sg"].ingress_1.from_port
  to_port           = var.security_group_config["test_sg"].ingress_1.to_port
  protocol          = var.security_group_config["test_sg"].ingress_1.protocol
  cidr_blocks       = [var.security_group_config["test_sg"].ingress_1.cidr_blocks]
  security_group_id = aws_security_group.test_security_group.id
}
