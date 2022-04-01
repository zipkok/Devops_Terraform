output "sg_id" {
  value       = module.blog_backend.security_group_id
  description = "Security Group ID"
}

resource "aws_security_group_rule" "ingress_rule_1" {
  security_group_id        = module.blog_backend.security_group_id
  description              = "Frontend -> Backend"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_frontend.outputs.sg_id
}

resource "aws_security_group_rule" "egress_rule_1" {
  security_group_id        = module.blog_frontend.security_group_id
  description              = "Backend -> Frontend"
  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_frontend.outputs.sg_id
}

resource "aws_security_group_rule" "ingress_rule_2" {
  security_group_id        = module.blog_backend.security_group_id
  description              = "DB -> Backend"
  type                     = "ingress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_db.outputs.sg_id
}

resource "aws_security_group_rule" "egress_rule_2" {
  security_group_id        = module.blog_frontend.security_group_id
  description              = "Backend -> DB"
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

# terraform_remote_state 읽기
data "terraform_remote_state" "blog_frontend" {
  backend = "s3"
  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/service/blog/frontend/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

# terraform_remote_state 읽기
data "terraform_remote_state" "blog_db" {
  backend = "s3"
  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/service/blog/data-store/terraform.tfstate"
    region = "ap-northeast-2"
  }
}
