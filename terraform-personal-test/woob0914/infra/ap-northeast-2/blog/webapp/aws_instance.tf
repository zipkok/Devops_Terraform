// subnet을 loop돌리니까, ec2_instance_name이 영향 받음. 서로 각자 loop가 실행됨..
module "blog-webapp" {
  source                      = "../../../../../modules/infra/service/aws_instance"
  // ec2_instance_name           = ["woobt-tfinf001", "woobt-tfinf002", "woobt-tfinf003", "woobt-tfinf004", "woobt-tfinf005", "woobt-tfinf006"]
  ec2_instance_name           = ["woobt-tfinf001", "woobt-tfinf002"]
  ec2_instance_security_group = ["sg-0fa0d3359fec65113", "sg-084a08cc5928568e8"]
  vpc_ec2_subnet_id           = ["subnet-095041c85bc79d384", "subnet-05a0afbf6beb61357"]

  ec2_instance_info = {
    ami                         = "ami-0cbec04a61be382d9"
    instance_type               = "t2.micro"
    key_name                    = "woob0914"
    associate_public_ip_address = true
  }

  ec2_root_volume = {
    volume_size           = 10
    delete_on_termination = true
    volume_type           = "gp3"
  }

  ec2_data_volume = {
    volume_size           = 10
    delete_on_termination = true
    volume_type           = "gp3"
  }

  ec2_instance_tags = {
    creator   = "Woobeom"
    team      = "플랫폼서비스운영팀"
    project   = "rx"
    service   = "media"
    terraform = "true"
  }
}