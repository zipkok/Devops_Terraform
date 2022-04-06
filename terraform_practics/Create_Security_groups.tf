# Security Group module variables
variable "security_group_config" {
  type = object({
    name        = string
    description = string
    vpc_id      = string
  })
}

variable "security_group_tags" {
  type = map(string)
}


resource "aws_security_group" "security_group" {
  name        = var.security_group_config.name
  description = var.security_group_config.description
  vpc_id      = var.security_group_config.vpc_id
  
  tags        = var.security_group_tags
}

resource "aws_security_group_rule" "ingress_rule_1" {
  security_group_id        = module.blog_backend.security_group_id
  description              = "Frontend_To_Backend"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_frontend.outputs.sg_id
}

resource "aws_security_group_rule" "egress_rule_1" {
  security_group_id        = module.blog_backend.security_group_id
  description              = "Backend_To_Frontend"
  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_frontend.outputs.sg_id
}

resource "aws_security_group_rule" "ingress_rule_2" {
  security_group_id        = module.blog_backend.security_group_id
  description              = "DB_To_Backend"
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_db.outputs.sg_id
}

resource "aws_security_group_rule" "egress_rule_2" {
  security_group_id        = module.blog_backend.security_group_id
  description              = "Backend_To_DB"
  type                     = "egress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_db.outputs.sg_id
}



module "blog_backend" {
  source = "../../../../../modules/infra/service/sg"

  security_group_config = {
    name        = "blog_back_sg"
    description = "security_group_describe"
    vpc_id      = "vpc-0546f3f1c47f1f95e"
  }

  security_group_tags = {
    Name    = "blog_back_sg"
    Creator = "Woobeom"
  }
}