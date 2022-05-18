# =================================================================================
# Security Group - [Blog] Default SG ==============================================
# =================================================================================
resource "aws_security_group" "default_security_group" {
  name        = var.default_security_group.config.name
  description = var.default_security_group.config.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.default_security_group.config.name
    Team        = var.common_security_group_tags.Team
    Creator     = var.common_security_group_tags.Creator
    IsTerraform = var.common_security_group_tags.IsTerraform
  }
}

resource "aws_security_group_rule" "default_security_group_ingress_1" {
  type              = var.default_security_group.ingress_1.type
  from_port         = var.default_security_group.ingress_1.from_port
  to_port           = var.default_security_group.ingress_1.to_port
  protocol          = var.default_security_group.ingress_1.protocol
  cidr_blocks       = [var.default_security_group.ingress_1.cidr_blocks]
  security_group_id = aws_security_group.default_security_group.id
}

# =================================================================================
# Security Group - [Blog] EC2 SG ==================================================
# =================================================================================
resource "aws_security_group" "ec2_security_group" {
  name        = var.ec2_security_group.config.name
  description = var.ec2_security_group.config.description
  vpc_id      = var.vpc_id
  tags = {
    Name        = var.ec2_security_group.config.name
    Team        = var.common_security_group_tags.Team
    Creator     = var.common_security_group_tags.Creator
    IsTerraform = var.common_security_group_tags.IsTerraform
  }
}

resource "aws_security_group_rule" "ec2_security_group_ingress_1" {
  type              = var.ec2_security_group.ingress_1.type
  from_port         = var.ec2_security_group.ingress_1.from_port
  to_port           = var.ec2_security_group.ingress_1.to_port
  protocol          = var.ec2_security_group.ingress_1.protocol
  cidr_blocks       = [var.ec2_security_group.ingress_1.cidr_blocks]
  security_group_id = aws_security_group.ec2_security_group.id
}
