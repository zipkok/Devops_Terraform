variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = < VPC-ID >
}

data "aws_vpc" "dta_vpc_id" {
  id = var.vpc_id
}

output "vpc" {
  value = data.aws_vpc.dta_vpc_id.id
}

data "aws_subnets" "dta_aws_subnet_ids" {
  filter {
    name   = "vpc_id"
    values = [data.aws_vpc.dta_vpc_id.id]
  }
}

output "subent_cidr_blocks" {
  value = data.aws_subnets.dta_aws_subnet_ids.dis
}