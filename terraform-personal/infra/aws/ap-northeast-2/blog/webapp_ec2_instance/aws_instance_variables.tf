variable "subnet_ids" {
  type = list(any)
}

variable "ec2_security_groups" {
  type = list(any)
}
variable "vpc_id" {
  type = string
}

variable "common_ec2_tags" {
  type = map(any)
}

variable "ec2_instance_config" {
  type = map(any)
}

variable "ec2_name_tag" {
  type = list(any)
}

variable "alb_lb_config" {
  type = map(any)
}

variable "alb_lb_security_groups" {
  type = list(any)
}