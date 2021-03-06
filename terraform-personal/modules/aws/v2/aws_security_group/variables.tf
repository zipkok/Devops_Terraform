# Security Group module variables
variable "vpc_id" {
  type = string
}

variable "security_group_config" {
  type = list(any)
}

variable "security_group_tags" {
  type = map(any)
}
