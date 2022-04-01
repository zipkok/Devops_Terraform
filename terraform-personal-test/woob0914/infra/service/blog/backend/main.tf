output "blog_backend" {
  value       = module.blog_backend.security_group_id
  description = "Security Group ID"
}

resource "aws_security_group_rule" "backend_ingress" {
  security_group_id        = module.blog_backend.security_group_id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "tcp"
  source_security_group_id = data.terraform_remote_state.outputs.blog_frontend
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

// terraform_remote_state 읽기
data "terraform_remote_state" "blog_frontend" {
  backend = "s3"
  config = {
    bucket = "woobeom-terraform-bucket"
    key    = "woob0914/infra/service/blog/frontend/terraform.tfstate"
    region = "ap-northeast-2"
  }
}