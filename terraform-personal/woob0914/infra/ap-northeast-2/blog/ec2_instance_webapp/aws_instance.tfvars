# =================================================================================
# Set a subnet_ids for Security Group =============================================
# =================================================================================
subnet_ids = ["subnet-095041c85bc79d384", "subnet-05a0afbf6beb61357"]

# =================================================================================
# Require Tags
# Team, Creator, Service, Project, IsTerraform 
# =================================================================================
common_ec2_tags = {
  Team        = "zipkok"
  Creator     = "Woobeom"
  Service     = "service"
  Project     = "project"
  IsTerraform = true
}

# =================================================================================
# Security Group Configuration ====================================================
# =================================================================================
ec2_name_config = {
  ami                         = "ami-0cbec04a61be382d9"
  instance_type               = "t2.micro"
  key_name                    = "woob0914"
  associate_public_ip_address = true
  ec2_root_volume             = 10
  ec2_data_volume             = 10
}

ec2_name_tag = [
  "woobeom1",
  "woobeom2"
]
