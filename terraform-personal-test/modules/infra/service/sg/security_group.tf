# Module Resource 

resource "aws_security_group" "security_group" {
  name        = var.security_group_config.name
  description = var.security_group_config.description
  vpc_id      = var.security_group_config.vpc_id
  tags        = var.security_group_tags
}

resource "aws_security_group_rule" "security_group_ingress_rules" {
  security_group_id = aws_security_group.security_group.id
  type              = "ingress"
  count             = length(var.ingress_rules)
  description       = var.ingress_rules[count.index].description
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = ["${var.ingress_rules[count.index].cidr_blocks}"]
}

resource "aws_security_group_rule" "security_group_egress_rules" {
  security_group_id = aws_security_group.security_group.id
  type              = "egress"
  count             = length(var.egress_rules)
  description       = var.egress_rules[count.index].description
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = ["${var.egress_rules[count.index].cidr_blocks}"]
}