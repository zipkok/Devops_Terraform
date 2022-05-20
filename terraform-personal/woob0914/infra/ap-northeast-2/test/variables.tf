
variable "sg_name" {
  type = string
}

variable "sg_description" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "sg_tags" {
  type = object({
    Name      = string
    Creator   = string
    terraform = bool
    using     = number
  })
}