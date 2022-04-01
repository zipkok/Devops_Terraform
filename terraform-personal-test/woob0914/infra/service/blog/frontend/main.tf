output "blog_frontend" {
  value       = module.blog_frontend.security_group_id
  description = "Security Group ID"
}

resource "aws_security_group_rule" "backend_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.blog_frontend.security_group_id
  cidr_blocks       = ["10.10.10.10/24"]

}

module "blog_frontend" {
  source = "../../../../../modules/infra/service/sg"

  security_group_config = {
    name        = "blog_front_sg"
    description = "security_group_describe"
    vpc_id      = "vpc-0546f3f1c47f1f95e"
  }

  security_group_tags = {
    Name    = "blog_front_sg"
    Creator = "Woobeom"
  }
}