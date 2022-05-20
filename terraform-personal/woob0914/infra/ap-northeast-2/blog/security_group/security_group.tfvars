# Set a VPC_ID of Security Group 
vpc_id = "vpc-0546f3f1c47f1f95e"

# Security Group Tags Configuration
common_security_group_tags = {
  Team        = "zipkok"
  Creator     = "Woobeom"
  IsTerraform = true
}

# Security Group Configuration
security_group_config = [
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
    name        = "TEST3"
    description = "module3 of Blog Service"
    ingress = [
      {
        description = "All Open"
        from_port   = 1025
        to_port     = 65535
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
      }
    ]
    egress = []
  },

  {
    name        = "TEST4"
    description = "module4 of Blog Service"
    ingress     = []
    egress      = []
  },
]


#Deprecated
deprecated_group_config = {
  default_sg = {
    config = {
      name        = "[Blog] Default SG"
      description = "Default SG of Blog Service"
    },

    ingress_1 = {
      name        = "All Open"
      type        = "ingress"
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  },

  test_sg = {
    config = {
      name        = "[TEST] Default SG"
      description = "TEST SG of Blog Service"
    },
    ingress_1 = {
      name        = "All Open"
      type        = "ingress"
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  },

  ec2_sg = {
    config = {
      name        = "[Blog] EC2 SG"
      description = "EC2 of Blog Service"
    },
    ingress_1 = {
      name        = "All Open"
      type        = "ingress"
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  },

  mdu_sg = {
    config = {
      name        = "[Blog] module SG"
      description = "module of Blog Service"
    },
    ingress_1 = {
      name        = "All Open"
      type        = "ingress"
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  },

  mdu2_sg = {
    config = {
      name        = "[TEST2] module SG"
      description = "module of Blog Service"
    },
    ingress = {
      name        = "All Open"
      type        = "ingress"
      from_port   = 1025
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  },
}
