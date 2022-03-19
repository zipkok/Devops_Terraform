provider "aws" {
  region = "ap-northeast-2"
}

data "aws_availability_zones" "all" {}

output "test" {
    value = data.aws_availability_zones.all
}