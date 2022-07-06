# Security Group의 terraform_remote_state 오픈
data "terraform_remote_state" "security_group_id" {
  backend = "s3"

  config = {
    key    = "infra/aws/ap-northeast-2/comm_security_group/terraform.tfstate"
    bucket = "woobeom-terraform-bucket"
    region = "ap-northeast-2"
  }
}
