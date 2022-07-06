
# VPC , Subnets
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(any)
}

# ALB Configuration
variable "alb_info" {
  type = map(any)
}
