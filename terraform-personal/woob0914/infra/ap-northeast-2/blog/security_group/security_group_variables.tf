variable "vpc_id" {
  type = string
}

variable "common_security_group_tags" {
  type = map(any)
}

variable "security_group_config" {
  type = list(any)
}
