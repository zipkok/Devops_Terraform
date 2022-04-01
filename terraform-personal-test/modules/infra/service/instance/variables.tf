# Security Group module variables
variable "ec2_instance_config" {
  type = object({
    ami                    = string
    instance_type          = string
    volume_size            = number
    vpc_security_group_ids = list
  })
}

variable "ec2_instance_tags" {
  type = map(string)
}