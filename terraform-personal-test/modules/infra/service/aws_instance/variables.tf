# New Config
variable "ec2_instance_info" {
  type = object({
    ami           = string
    instance_type = string
    key_name      = string
  })
}

// volume_size           = 20
// delete_on_termination = true
// volume_type           = "gp2"
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

variable "ec2_instance_security_group" {
  type = list(string)
}

variable "vpc_ec2_subnet_id" {
  type = string
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
