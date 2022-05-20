# Example tfvars ...
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