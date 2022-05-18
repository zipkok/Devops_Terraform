# Module Resource 
resource "aws_security_group" "security_group" {
  for_each    = { for k, value in var.security_group_config : value.name => k }
  name        = each.key
  description = var.security_group_config[each.value].description
  vpc_id      = var.vpc_id
  tags = {
    Name        = each.key
    Team        = var.security_group_tags.Team
    Creator     = var.security_group_tags.Creator
    IsTerraform = var.security_group_tags.IsTerraform
  }

  dynamic "ingress" {
    for_each = [for value in var.security_group_config[each.value].ingress : {
      description = value["description"]
      from_port   = value["from_port"]
      to_port     = value["to_port"]
      protocol    = value["protocol"]
      cidr_blocks = value["cidr_blocks"]
    }]
    content {
      description = ingress.value["description"]
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  dynamic "egress" {
    for_each = [for value in var.security_group_config[each.value].egress : {
      description = value["description"]
      from_port   = value["from_port"]
      to_port     = value["to_port"]
      protocol    = value["protocol"]
      cidr_blocks = value["cidr_blocks"]
    }]
    content {
      description = egress.value["description"]
      from_port   = egress.value["from_port"]
      to_port     = egress.value["to_port"]
      protocol    = egress.value["protocol"]
      cidr_blocks = egress.value["cidr_blocks"]
    }
  }
}
