variable "vpc_id" {
  type = string
}

variable "common_security_group_tags" {
  type = map(any)
}

variable "default_security_group_config" {
  type = list(any)
}

variable "ec2_security_group_config" {
  type = list(any)
}

variable "alb_security_group_config" {
  type = list(any)
}
