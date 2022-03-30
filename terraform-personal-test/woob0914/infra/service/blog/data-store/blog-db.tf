output "blog_db" {
  value       = module.blog_db.security_group_id
  description = "Connect to the database at this endPoint"
}

resource "aws_security_group_rule" "test" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  security_group_id        = module.blog_db.security_group_id
  source_security_group_id = "sg-0da40a67758e8612f"
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