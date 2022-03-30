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