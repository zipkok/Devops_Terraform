module "blog-frontend" {
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

  ingress_rules = [
    {
      description = "HTTP open"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "HTTPS open"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = [
    {
      description = "egress TESTs"
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

module "blog-backend" {
  source = "../../../../../modules/infra/service/sg"
  security_group_config = {
    name        = "blog_back_sg"
    description = "security_group_describes"
    vpc_id      = "vpc-0546f3f1c47f1f95e"
  }

  security_group_tags = {
    Name    = "blog_back_sg"
    Creator = "Woobeom"
  }

  ingress_rules = [
    {
      description = "HTTP open"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      description = "HTTPS open"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_rules = [
    {
      description = "egress TESTs"
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

