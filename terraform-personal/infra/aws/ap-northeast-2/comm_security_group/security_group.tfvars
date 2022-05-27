# =================================================================================
# Set a VPC_ID for Security Group =================================================
# =================================================================================
vpc_id = "vpc-0546f3f1c47f1f95e"

# =================================================================================
# Security Group Tags Configuration ===============================================
# =================================================================================
common_security_group_tags = {
  Team        = "zipkok"
  Creator     = "Woobeom"
  IsTerraform = true
}

# =================================================================================
# Security Group Configuration ====================================================
# =================================================================================
ec2_security_group_config = [
  {
    name        = "TEST2"
    description = "module2 of Blog Service"
    ingress = [
      {
        description = "All Open"
        from_port   = 1025
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "All Open"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ],
    egress = []
  },
  {
    name        = "TEST4"
    description = "module4 of Blog Service"
    ingress     = []
    egress      = []
  },
]

alb_security_group_config = [
  {
    name        = "TEST3"
    description = "module2 of Blog Service"
    ingress = [
      {
        description = "All Open"
        from_port   = 1025
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      },
      {
        description = "All Open"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ],
    egress = []
  }
]
