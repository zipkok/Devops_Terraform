# VPC 조회
data "aws_vpc" "default" {
  default = true
}

# =========================================================
# VPC 내 Subnet 조회
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

// terraform_remote_state 읽기
data "terraform_remote_state" "db" {
  backend = "s3"

  config = {
    bucket = var.db_remote_state_bucket
    key    = var.db_remote_state_key
    region = "ap-northeast-2"
  }
}

# template_file은 내장함수
# var.<NAME> 이 아닌 <NAME>으로 사용 가능함.
// data "template_file" "user_data" {
//   template = file("user-data.sh")

//   vars = {
//     server_port = var.server_port
//     db_address  = var.db_address
//     db_port     = var.db_port
//   }
// }