variable "subnet_ids" {
  type = list(any)
}

variable "security_groups" {
  type = list(any)
}

variable "common_ec2_tags" {
  type = map(any)
}

variable "ec2_name_config" {
  type = map(any)
}

variable "ec2_name_tag" {
  type = list(any)
}
