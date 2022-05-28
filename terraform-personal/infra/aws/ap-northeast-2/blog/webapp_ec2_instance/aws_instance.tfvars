# =================================================================================
# Set a subnet_ids for Security Group =============================================
# =================================================================================
vpc_id          = "vpc-0546f3f1c47f1f95e"
subnet_ids      = ["subnet-095041c85bc79d384", "subnet-05a0afbf6beb61357"]
ec2_security_groups = ["sg-0549e3add78710d17", "sg-0a6a1d155df3304ed"]

# =================================================================================
# Tags Configuration ==============================================================
# =================================================================================
common_ec2_tags = {
  Team        = "zipkok"
  Creator     = "Woobeom"
  Service     = "service"
  Project     = "project"
  IsTerraform = true
}

# =================================================================================
# EC2 Configuration ===============================================================
# =================================================================================
ec2_instance_config = {
  ami                         = "ami-0cbec04a61be382d9"
  instance_type               = "t2.micro"
  key_name                    = "woob0914"
  associate_public_ip_address = true
  ec2_root_volume             = 10
  ec2_data_volume             = 10
}

ec2_name_tag = [
  "woobeom11",
  "woobeom13",
  "woobeom13",
]

# =================================================================================
# ALB Configuration ===============================================================
# =================================================================================
alb_lb_config = {
  name                         = "woobeom-test-alb"
  load_balancer_type           = "application"
  client_to_alb_port           = 80
  client_to_alb_protocol       = "HTTP"
  alb_to_target_group_port     = 80
  alb_to_target_group_protocol = "HTTP"
}

alb_lb_security_groups = ["sg-0549e3add78710d17", "sg-0a6a1d155df3304ed"]
