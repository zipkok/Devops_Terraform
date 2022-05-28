# =====================================================================
# Network Config ======================================================
# =====================================================================
variable "vpc_ec2_subnet_id" {
  type = list(any)
}

variable "vpc_id" {
  type = string
}

# =====================================================================
# EC2 Config ==========================================================
# =====================================================================
variable "ec2_instance_info" {
  type = object({
    ami                         = string
    instance_type               = string
    key_name                    = string
    associate_public_ip_address = bool
  })
}

// volume_size           = 20
// delete_on_termination = true
// volume_type           = "gp3"
variable "ec2_root_volume" {
  type = object({
    volume_size           = number
    delete_on_termination = bool
    volume_type           = string
  })
}

variable "ec2_data_volume" {
  type = object({
    volume_size           = number
    delete_on_termination = bool
    volume_type           = string
  })
}

variable "ec2_instance_security_groups" {
  type = list(string)
}

// Creator = "woobeom"
// Team = "우리팀"
// Project = "rx
// Service = "media"
variable "ec2_instance_tags" {
  type = map(string)
}

variable "ec2_instance_name" {
  type = list(string)
}

# =====================================================================
# ALB Config ==========================================================
# =====================================================================
variable "alb_lb_info" {
  type = object({
    name                         = string
    load_balancer_type           = string
    client_to_alb_port           = number
    client_to_alb_protocol       = string
    alb_to_target_group_port     = number
    alb_to_target_group_protocol = string 
  })
}

variable "alb_security_groups" {
  type = list(string)
}
