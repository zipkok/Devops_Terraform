# Module Resource 

resource "aws_security_group" "sg_forntend" {
  name        = var.security_group_config.name
  description = var.security_group_config.description
  vpc_id      = var.security_group_config.vpc_id
  tags        = var.security_group_tags
}

resource "aws_security_group_rule" "sg_forntend_ingress" {
  security_group_id = aws_security_group.sg_forntend.id
  type              = "ingress"
  count             = length(var.ingress_rules)
  description       = var.ingress_rules[count.index].description
  from_port         = var.ingress_rules[count.index].from_port
  to_port           = var.ingress_rules[count.index].to_port
  protocol          = var.ingress_rules[count.index].protocol
  cidr_blocks       = ["${var.ingress_rules[count.index].cidr_blocks}"]
  source_security_group_id = var.ingress_rules[count.index].security_group_id
}

resource "aws_security_group_rule" "sg_forntend_egress" {
  security_group_id = aws_security_group.sg_forntend.id
  type              = "egress"
  count             = length(var.egress_rules)
  description       = var.egress_rules[count.index].description
  from_port         = var.egress_rules[count.index].from_port
  to_port           = var.egress_rules[count.index].to_port
  protocol          = var.egress_rules[count.index].protocol
  cidr_blocks       = ["${var.egress_rules[count.index].cidr_blocks}"]
  source_security_group_id = var.egress_rules[count.index].security_group_id
}