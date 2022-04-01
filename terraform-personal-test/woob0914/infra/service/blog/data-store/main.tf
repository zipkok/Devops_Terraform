output "sg_id" {
  value       = module.blog_db.security_group_id
  description = "Security Group ID"
}

resource "aws_security_group_rule" "ingress_rule_1" {
  security_group_id        = module.blog_db.security_group_id
  description              = "DB_To_Backend"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_backend.outputs.sg_id
}

resource "aws_security_group_rule" "egress_rule_1" {
  security_group_id        = module.blog_db.security_group_id
  description              = "DB_To_Backend"
  type                     = "egress"
  from_port                = 1025
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.blog_backend.outputs.sg_id
}


module "blog_db" {
  source = "../../../../../modules/infra/service/sg"

  security_group_config = {
    name        = "blog_db_sg"
    description = "security_group_describe"
    vpc_id      = "vpc-0546f3f1c47f1f95e"
  }

  security_group_tags = {
    Name    = "blog_db_sg"
    Creator = "Woobeom"
  }
}

data "terraform_remote_state" "blog_backend" {
  backend = "s3"
  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/service/blog/backend/terraform.tfstate"
    region = "ap-northeast-2"
  }
}