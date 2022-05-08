// subnet을 loop돌리니까, ec2_instance_name이 영향 받음. 서로 각자 loop가 실행됨..
module "blog-webapp" {
  source                      = "../../../../../modules/infra/service/aws_instance"
  ec2_instance_name           = ["wakrl-rxmda001", "wakrl-rxmda002", "wakrl-rxmda004", "wakrl-rxmda005"]
  ec2_instance_security_group = ["sg-0fa0d3359fec65113", "sg-084a08cc5928568e8"]
  vpc_ec2_subnet_id           = ["subnet-095041c85bc79d384", "subnet-05a0afbf6beb61357"]

  ec2_instance_info = {
    ami           = "ami-0cbec04a61be382d9"
    instance_type = "t2.micro"
    key_name      = "woob0914"
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



// resource " aws_instance " " my-app1 " {
//   ami                         = " ami-0cbec04a61be382d9 "
//   availability_zone           = " ap-northeast-2a "
//   ebs_optimized               = false
//   instance_type               = " t2.micro "
//   monitoring                  = false
//   key_name                    = " woob0914 "
//   subnet_id                   = " subnet-095041c85bc79d384 "
//   vpc_security_group_ids      = [" sg-0979156848f949963 "]
//   associate_public_ip_address = true
//   source_dest_check           = true

//   root_block_device {
//     volume_type           = " gp2 "
//     volume_size           = 8
//     delete_on_termination = true
//   }

//   tags = {
//     Name = " my-app1 "
//   }
// }

// resource " aws_instance " " my-app2 " {
//   ami                         = " ami-0cbec04a61be382d9 "
//   availability_zone           = " ap-northeast-2a "
//   ebs_optimized               = false
//   instance_type               = " t2.micro "
//   monitoring                  = false
//   key_name                    = " woob0914 "
//   subnet_id                   = " subnet-095041c85bc79d384 "
//   vpc_security_group_ids      = [" sg-0979156848f949963 "]
//   associate_public_ip_address = true

//   root_block_device {
//     volume_type           = " gp2 "
//     volume_size           = 8
//     delete_on_termination = true
//   }

//   tags = {
//     Name = " my-app2 "
//   }
// }


// resource " aws_alb " " external-web-lb " {
//   idle_timeout    = 60
//   internal        = false
//   name            = " external-web-lb "
//   security_groups = [" sg-0fa0d3359fec65113 "]
//   subnets         = [" subnet-05a0afbf6beb61357 ", " subnet-095041c85bc79d384 ", " subnet-0bb6b78a4fb764f01 ", " subnet-0e13b6cc838741021 "]

//   enable_deletion_protection = false

//   tags = {
//     ELB  = " external "
//     Name = " external-web-lb "
//   }
// }

// resource " aws_alb " " internals-web-lb " {
//   idle_timeout    = 60
//   internal        = true
//   name            = " internals-web-lb "
//   security_groups = [" sg-0fc6def9315d80d7c "]
//   subnets         = [" subnet-05a0afbf6beb61357 ", " subnet-095041c85bc79d384 ", " subnet-0bb6b78a4fb764f01 ", " subnet-0e13b6cc838741021 "]

//   enable_deletion_protection = false

//   tags = {
//     ELB  = " Internal "
//     Name = " internals-web-lb "
//   }
// }

