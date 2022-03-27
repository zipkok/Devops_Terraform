module "frontend" {
  source = "../../../../../modules/infra/service/sg"
  security_group_config = {
    name        = "security_group_name"
    description = "security_group_describe"
    vpc_id      = "vpc-0546f3f1c47f1f95e"
  }

  security_group_tags = {
    Name    = "woobeom_test"
    Creator = "Woobeom"
  }

  ingress_rules = [
    {
      description = "ingress TEST"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
      }, {
      description = "ingress TEST"
      from_port   = 0
      to_port     = 0
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
  }]

  egress_rules = [
    {
      description = "egress TEST"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "egress TEST"
      from_port   = 0
      to_port     = 0
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
  }]
}
