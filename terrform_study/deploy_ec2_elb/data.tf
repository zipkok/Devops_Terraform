# VPC 조회
data "aws_vpc" "default" {
  default = true
}

# =========================================================
# VPC 내 Subnet 조회
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}