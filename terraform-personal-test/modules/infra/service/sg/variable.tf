# Security Group module variables

variable "security_group_config" {
  type = object({
    name        = string
    description = string
    vpc_id      = string
  })
}

variable "security_group_tags" {
  type = map(string)
}

variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
}

variable "egress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
  }))
}