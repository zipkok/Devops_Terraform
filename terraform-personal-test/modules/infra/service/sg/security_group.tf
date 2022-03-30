# Module Resource 

resource "aws_security_group" "security_group" {
  name        = var.security_group_config.name
  description = var.security_group_config.description
  vpc_id      = var.security_group_config.vpc_id
  tags        = var.security_group_tags
}