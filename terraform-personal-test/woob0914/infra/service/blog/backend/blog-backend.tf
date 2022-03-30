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
}