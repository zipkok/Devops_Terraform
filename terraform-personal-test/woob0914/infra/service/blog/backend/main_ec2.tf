module "backendt_ec2" {
  source = "../../../../../modules/infra/service/instance"

  ec2_instance_config = {
    ami                    = "ami-033a6a056910d1137"
    instance_type          = "t2.micro"
    volume_size            = 20
    vpc_security_group_ids = [module.blog_backend.security_group_id, "sg-0c2fcc58ef7165fd5"]
  }

  ec2_instance_tags = {
    Name    = "Backend_EC2"
    Creator = "Woobeom"
  }
}